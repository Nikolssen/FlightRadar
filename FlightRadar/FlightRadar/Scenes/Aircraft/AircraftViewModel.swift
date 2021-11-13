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
    var icaoNumber: String? { get }
    var numberOfEngines: String? { get }
    var age: String? { get }
    var firstFlightDate: String? { get }
    var numberOfSeats: String? { get }
    var title: String? { get }
    
    var updateRelay: PublishRelay<Void> { get }
    var startRelay: PublishRelay<Bool> { get }
    var urlDataSource: BehaviorRelay<[URL]> { get }
    var activityIndicatorRelay: PublishRelay<Bool> { get }
}

protocol AircraftCoordinator {
    var popRelay: PublishRelay<Void> { get }
}

class AircraftViewModel: AircraftViewModelling {
    var title: String? {
        modelRelay.value?.productionLine
    }
    
    var registrationNumber: String? {
        modelRelay.value?.registration
    }
    
    var icaoNumber: String? {
        modelRelay.value?.icao
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
    
    var numberOfSeats: String? {
        guard let number = modelRelay.value?.numberOfSeats else { return nil }
        return "\(number)"
    }
    let urlDataSource: BehaviorRelay<[URL]> = .init(value: [])
    let updateRelay: PublishRelay<Void> = .init()
    let startRelay: PublishRelay<Bool> = .init()
    let activityIndicatorRelay: PublishRelay<Bool> = .init()
    private var modelRelay: BehaviorRelay<Aircraft?> = .init(value: nil)
    
    private let service: Services
    private let coordinator: AircraftCoordinator
    
    private let disposeBag: DisposeBag = .init()
    
    init(coordinator: AircraftCoordinator, service: Services, icao24: String) {
        self.service = service
        self.coordinator = coordinator
        
        startRelay
            .do(onNext: { [weak self] _ in self?.activityIndicatorRelay.accept(true) })
            .observe(on: SerialDispatchQueueScheduler.init(qos: .utility))
            .flatMap { [service] _ -> Observable<Aircraft> in
                    service.networkService.request(request: .aircraft(icao24: icao24))
                }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {[weak self] in
                self?.modelRelay.accept($0)
                self?.updateRelay.accept(Void())
            }, onError: { [weak self] _ in
                self?.coordinator.popRelay.accept(Void())})
            .disposed(by: disposeBag)
        
        startRelay
            .observe(on: SerialDispatchQueueScheduler.init(qos: .utility))
            .flatMap { [service] _ -> Observable<AircraftImage> in
                service.networkService.request(request: .aircraftImage(icao24: icao24))}
            .compactMap { (imageModel: AircraftImage) -> URL? in
                URL(string: imageModel.url)
            }
            .subscribe(onNext: {[weak self] in
                self?.urlDataSource.accept([$0])
            }, onError: {error in })
            .disposed(by: disposeBag)
    }
}
