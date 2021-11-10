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

    var urlDataSource: BehaviorRelay<[URL]> { get }
    var registrationNumber: String? { get }
    var icaoNumber: String? { get }
    var numberOfEngines: String? { get }
    var age: String? { get }
    var firstFlightDate: String? { get }
    var numberOfSeats: String? { get }
    var title: String? { get }
    var updateRelay: PublishRelay<Void> { get }
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
    
    private let service: Services
    private var modelRelay: BehaviorRelay<Aircraft?> = .init(value: nil)
    private let disposeBag: DisposeBag = .init()

    
    init(service: Services, icao24: String) {
        self.service = service
        service.networkService.request(request: .aircraft(icao24: icao24))
            .subscribe(onNext: {[weak self] in
                self?.modelRelay.accept($0)
            }, onError: {error in })
            .disposed(by: disposeBag)
        
        service.networkService.request(request: .aircraftImage(icao24: icao24))
            .compactMap { (imageModel: AircraftImage) -> URL? in
                URL(string: imageModel.url)
            }
            .subscribe(onNext: {[weak self] in
                self?.urlDataSource.accept([$0])
            }, onError: {error in })
            .disposed(by: disposeBag)
        
        modelRelay
            .skip(1)
            .map {_ in Void() }
            .bind(to: updateRelay)
            .disposed(by: disposeBag)
    }
}
