//
//  AirportCellViewModel.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/29/21.
//

import Foundation
protocol AirportCellViewModelling {
    
    var distance: String? { get }
    var name: String { get }
    var abbreviations: String { get }
    
    init(model: AirportModel, using service: LocationService)
}

struct AirportCellViewModel: AirportCellViewModelling {
    
    let distance: String?
    let name: String
    let abbreviations: String
    
    
    init(model: AirportModel, using service: LocationService) {
        self.name = model.name ?? Constants.unnamedAirport
        self.abbreviations = [model.iata, model.icao].compactMap{ $0 }.joined(separator: "/")
        guard let location = model.location, let distance = service.distance(from: (latitude: location.lat, longitude: location.lon)), let value = NumberFormatter.round(number: distance / 1000) else {
            self.distance = nil
            return
        }
        self.distance = value + Constants.kilometers
        
    }
    
    init(distance: String, name: String, abbreviations: String) {
        self.distance = distance
        self.name = name
        self.abbreviations = abbreviations
    }
    
    
    private enum Constants {
        static let unnamedAirport: String = "Unnamed airport"
        static let kilometers: String = "km"
    }
}
