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
    var dataSourceRelay: PublishRelay<[AirportViewViewModelling]> { get }
    var selectedIndexRelay: PublishRelay<Int> { get }
}


final class AirportSelectionViewModel {
    let dismissalRelay: PublishRelay<Void> = .init()
    let dataSourceRelay: PublishRelay<[AirportViewViewModelling]> = .init()
    let selectedIndexRelay: PublishRelay<Int> = .init()
    
    private let disposeBag: DisposeBag = .init()
    private let service: Services
    weak var viewModel: TicketsViewModelling?
    private let valuesRelay: BehaviorRelay<[AirportModel]> = .init(value: [])
    init(service: Services, viewModel: TicketsViewModelling) {
        self.service = service
        self.viewModel = viewModel
        
        service
            .persistanceService
            .fetchAirports()
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: {[valuesRelay] in valuesRelay.accept($0) },
                       onFailure: {[dismissalRelay] _ in dismissalRelay.accept(Void())  })
            .disposed(by: disposeBag)
        
        valuesRelay
            .observe(on: SerialDispatchQueueScheduler.init(qos: .utility))
            .map { [service] in $0.map { AirportViewViewModel(model: $0, using: service.locationService)}}
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: dataSourceRelay)
            .disposed(by: disposeBag)
    }
}
