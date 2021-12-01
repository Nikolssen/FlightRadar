//
//  FlightModalViewViewModel.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 12/1/21.
//

import Foundation

struct FlightModalViewViewModel {
    let arrivalDate: String
    let departureDate: String
    let company: String
    let destinationCode: String
    let originCode: String
    let status: String
    let flightTime: String
    
    var flightViewViewModel: FlightViewViewModel {
        FlightViewViewModel(destinationCode: destinationCode, originCode: originCode,
                            status: status, flightTime: flightTime)
    }
}
