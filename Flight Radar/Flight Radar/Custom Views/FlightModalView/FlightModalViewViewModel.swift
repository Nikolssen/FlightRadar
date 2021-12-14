//
//  FlightModalViewViewModel.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 12/1/21.
//

import Foundation

struct FlightModalViewViewModel {
    
    init(flightInfo: FlightResponseModel.Data) {
        self.flightInfo = flightInfo
    }
    
    private let flightInfo: FlightResponseModel.Data
    
    var flightViewViewModel: FlightViewViewModel {
        FlightViewViewModel(destinationCode: flightInfo.arrival?.iata ?? "", originCode: flightInfo.departure?.iata ?? "",
                            status: "", flightTime: DateFormatter.substract(flightInfo.departure?.time, d2: flightInfo.arrival?.time) ?? "")
    }
    
    var company: String? {
        flightInfo.airline?.name
    }
    var departureDate: String? {
        DateFormatter.extendedDate(from: flightInfo.departure?.time)
    }
    var arrivalDate: String? {
        DateFormatter.extendedDate(from: flightInfo.arrival?.time)
    }
    
}
