//
//  AirportSelectionViewModel.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/12/21.
//

import Foundation
import RxRelay
import RxSwift

protocol AirportSelectionViewModelling {
    var dismissalRelay: PublishRelay<Void> { get }
    var dataSourceRelay: BehaviorRelay<[AirportViewViewModelling]> { get }
    var selectedIndexRelay: PublishRelay<Int> { get }
}

protocol AirportSelectionCoordinator: ErrorHandler {
    var selectedAirportRelay: PublishRelay<String?> { get }
    var dismissalRelay: PublishRelay<Void> { get }
}

final class AirportSelectionViewModel: AirportSelectionViewModelling {
    let dismissalRelay: PublishRelay<Void> = .init()
    let dataSourceRelay: BehaviorRelay<[AirportViewViewModelling]> = .init(value: [])
    let selectedIndexRelay: PublishRelay<Int> = .init()
    private let coordinator: AirportSelectionCoordinator
    private let disposeBag: DisposeBag = .init()
    private let service: Services
    private let valuesRelay: BehaviorRelay<[AirportModel]> = .init(value: [])
    
    init(service: Services, coordinator: AirportSelectionCoordinator) {
        self.service = service
        self.coordinator = coordinator
        service
            .persistanceService
            .fetchAirports()
            .observe(on: MainScheduler.instance)
            .do(onError: {[coordinator] in coordinator.errorHandlerRelay.accept($0)})
            .subscribe(onSuccess: {[valuesRelay] in valuesRelay.accept($0) },
                       onFailure: {[dismissalRelay] _ in dismissalRelay.accept(Void())  })
            .disposed(by: disposeBag)
        
        valuesRelay
            .observe(on: SerialDispatchQueueScheduler.init(qos: .utility))
            .map { [service] in $0.map { AirportViewViewModel(model: $0, using: service.locationService)}}
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: dataSourceRelay)
            .disposed(by: disposeBag)
        
        selectedIndexRelay
            .withLatestFrom(valuesRelay) { $1[$0].iata }
            .bind(to: coordinator.selectedAirportRelay)
            .disposed(by: disposeBag)
        
        dismissalRelay
            .bind(to: coordinator.dismissalRelay)
            .disposed(by: disposeBag)
        
    }
}
