//
//  AircraftViewModel.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/8/21.
//

import Foundation
import RxRelay
import RxSwift

protocol AircraftViewModelling {

    var registrationNumber: String? { get }
    var owner: String? { get }
    var numberOfEngines: String? { get }
    var age: String? { get }
    var firstFlightDate: String? { get }
    var title: String? { get }
    
    var updateRelay: PublishRelay<Void> { get }
    var startRelay: PublishRelay<Bool> { get }
    var urlDataSource: BehaviorRelay<[URL]> { get }
    var activityIndicatorRelay: PublishRelay<Bool> { get }
}

protocol AircraftCoordinator {
    var popRelay: PublishRelay<Void> { get }
}

final class AircraftViewModel: AircraftViewModelling {
    var title: String? {
        modelRelay.value?.productionLine ?? Constants.defaultTitle
    }
    
    var registrationNumber: String? {
        modelRelay.value?.registration
    }
    
    var owner: String? {
        modelRelay.value?.owner
    }
    
    var numberOfEngines: String? {
        guard let number = modelRelay.value?.numberOfEngines else { return nil }
        return "\(number)"
    }
    
    var age: String? {
        guard let age = modelRelay.value?.age else { return nil }
        return NumberFormatter.round(number: age)
    }
    
    var firstFlightDate: String? {
        DateFormatter.date(from: modelRelay.value?.firstFlight)
    }
    
    let urlDataSource: BehaviorRelay<[URL]> = .init(value: [])
    let updateRelay: PublishRelay<Void> = .init()
    let startRelay: PublishRelay<Bool> = .init()
    let activityIndicatorRelay: PublishRelay<Bool> = .init()
    private var modelRelay: BehaviorRelay<Aircraft?> = .init(value: nil)
    
    private let service: Services
    private let coordinator: AircraftCoordinator
    
    private let disposeBag: DisposeBag = .init()
    
    init(coordinator: AircraftCoordinator, service: Services, registration: String) {
        self.service = service
        self.coordinator = coordinator
        
        startRelay
            .do(onNext: { [weak self] _ in self?.activityIndicatorRelay.accept(true) })
            .observe(on: SerialDispatchQueueScheduler.init(qos: .utility))
            .flatMap { [service] _ -> Observable<Aircraft> in
                service.networkService.request(request: .aircraft(registration: registration))
                }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {[weak self] in
                self?.activityIndicatorRelay.accept(false)
                self?.modelRelay.accept($0)
                self?.updateRelay.accept(Void())
            }, onError: { [weak self] _ in
                self?.coordinator.popRelay.accept(Void())})
            .disposed(by: disposeBag)
        
        startRelay
            .observe(on: SerialDispatchQueueScheduler.init(qos: .utility))
            .flatMap { [service] _ -> Observable<AircraftImage> in
                service.networkService.request(request: .aircraftImage(registration: registration))}
            .compactMap { (imageModel: AircraftImage) -> URL? in
                URL(string: imageModel.url)
            }
            .subscribe(onNext: {[weak self] in
                self?.urlDataSource.accept([$0])
            }, onError: {error in })
            .disposed(by: disposeBag)
    }
    
    private enum Constants {
        static let defaultTitle: String = "Unknown model"
    }
}
