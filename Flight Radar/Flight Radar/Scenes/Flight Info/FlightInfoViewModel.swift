//
//  FlightInfoViewModel.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 12/7/21.
//

import Foundation
import Combine

final class FlightInfoViewModel: ObservableObject {
    private let flightInfo: FlightResponseModel.Data
    let companySelectionRelay: PassthroughSubject<Void, Never> = .init()
    let aircraftSelectionRelay: PassthroughSubject<Void, Never> = .init()
    var subscribtions: Set<AnyCancellable> = .init()
    
    var flightViewViewModel: FlightViewViewModel {
        FlightViewViewModel(destinationCode: flightInfo.departure?.iata ?? "", originCode: flightInfo.arrival?.iata ?? "", status: flightInfo.flightStatus ?? "", flightTime: DateFormatter.substract(flightInfo.departure?.time, d2: flightInfo.arrival?.time) ?? "" )
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
        flightInfo.aircraft?.registration != nil
    }
    
    var isCompanyAvailable: Bool {
        flightInfo.airline?.icao != nil
    }
    
    init(model: FlightResponseModel.Data) {
        flightInfo = model
    
    }
}
