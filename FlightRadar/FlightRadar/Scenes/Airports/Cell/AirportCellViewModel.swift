//
//  AirportCellViewModel.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/29/21.
//

import Foundation
protocol AirportCellViewModelling {
    
    var distance: String { get }
    var name: String { get }
    var abbreviations: String { get }
    var index: Int { get }
    
    init(model: AirportModel, using service: LocationService, index: Int)
}

struct AirportCellViewModel {
    
    let distance: String
    let name: String
    let abbreviations: String
    let index: Int
    
    
    init(model: AirportModel, using service: LocationService, index: Int) {
        self.name = model.name ?? Constants.unnamedAirport
        self.abbreviations = [model.icao, model.iata].compactMap{ $0 }.joined(separator: "/")
        self.index = index
        guard let location = model.location, let distance = service.distance(from: (latitude: location.lat, longitude: location.lon)) else {
            self.distance = ""
            return
        }
        self.distance = "\(distance / 1000)" + Constants.kilometers
        
    }
    
    init(distance: String, name: String, abbreviations: String, index: Int) {
        self.distance = distance
        self.name = name
        self.abbreviations = abbreviations
        self.index = index
    }
    
    
    private enum Constants {
        static let unnamedAirport: String = "Unnamed airport"
        static let kilometers: String = "km"
    }
}
