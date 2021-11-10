//
//  FlightViewModel.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/9/21.
//

import Foundation
import RxRelay
import RxSwift

protocol FlightViewModelling {

    var flightViewViewModel: FlightViewViewModel { get }
    
    var company: String? { get }
    var departure: String? { get }
    var arrival: String? { get }
    var departureAirport: String? { get }
    var arrivalAirport: String? { get }
    var isAircraftAvailable: Bool { get }
    var isCompanyAvailable: Bool { get }
    var companySelectionRelay: PublishRelay<Void> { get }
    var aircraftSelectionRelay: PublishRelay<Void> { get }
    
}

protocol FlightCoordinator {
    var companySelectionRelay: PublishRelay<Void> { get }
    var aircraftSelectionRelay: PublishRelay<Void> { get }
}

final class FlightViewModel: FlightViewModelling {

    private let flightInfo: FlightResponseModel.Data
    private let disposeBag: DisposeBag = .init()
    private let coordinator: FlightCoordinator
    let companySelectionRelay: PublishRelay<Void> = .init()
    let aircraftSelectionRelay: PublishRelay<Void> = .init()
    
    var flightViewViewModel: FlightViewViewModel {
        FlightViewViewModel(departureCode: flightInfo.departure?.iata, arrivalCode: flightInfo.arrival?.iata, time: DateFormatter.substract(flightInfo.departure?.time, d2: flightInfo.arrival?.time))
    }

    var company: String? {
        flightInfo.airline?.name
    }
    var departure: String? {
        DateFormatter.extendedDate(from: flightInfo.departure?.time)
    }
    var arrival: String? {
        DateFormatter.extendedDate(from: flightInfo.arrival?.time)
    }
    var departureAirport: String? {
        flightInfo.departure?.airport
    }
    
    var arrivalAirport: String? {
        flightInfo.arrival?.airport
    }
    
    var isAircraftAvailable: Bool {
        flightInfo.aircraft?.icao24 != nil
    }
    
    var isCompanyAvailable: Bool {
        flightInfo.airline?.icao != nil
    }
    
    init(coordinator: FlightCoordinator, flightInfo: FlightResponseModel.Data) {
        self.coordinator = coordinator
        self.flightInfo = flightInfo
        companySelectionRelay
            .bind(to: coordinator.companySelectionRelay)
            .disposed(by: disposeBag)
        aircraftSelectionRelay
            .bind(to: coordinator.aircraftSelectionRelay)
            .disposed(by: disposeBag)
    }
    
}
