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
    var company: String? { get }
    var numberOfEngines: String? { get }
    var age: String? { get }
    var firstFlightDate: String? { get }
    var numberOfSeats: String? { get }
}

class AircraftViewModel: AircraftViewModelling {
    
    var registrationNumber: String?
    
    var icaoNumber: String?
    
    var company: String?
    
    var numberOfEngines: String?
    
    var age: String?
    
    var firstFlightDate: String?
    
    var numberOfSeats: String?
    
    let service: Services
    
    let urlDataSource: BehaviorRelay<[URL]> = .init(value: [])
    
    init(service: Services) {
        self.service = service
        
    }
}
