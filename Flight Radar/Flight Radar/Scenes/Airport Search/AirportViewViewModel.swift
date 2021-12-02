//
//  AirportViewViewModel.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/25/21.
//

import Foundation
import CoreLocation
import SwiftUI

struct AirportViewViewModel {

    
    let distance: String
    let name: String
    let abbreviations: String
    let index: Int
    
    
    init(model: AirportModel, using locationManager: LocationManager, index: Int) {
        self.name = model.name ?? "Unnamed Airport"
        self.index = index
        self.abbreviations = [model.icao, model.iata].compactMap{ $0 }.joined(separator: "/")
        guard let location = model.location, let distance = locationManager.distance(from: (latitude: location.lat, longitude: location.lon)), let value = NumberFormatter.round(number: distance / 1000) else {
            self.distance = ""
            return
        }
        self.distance = value + Constants.kilometers
        
    }
    
    init(distance: String, name: String, abbreviations: String, index: Int) {
        self.distance = distance
        self.name = name
        self.abbreviations = abbreviations
        self.index = index
    }

    
    private enum Constants {
        static let unnamedAirport: LocalizedStringKey = "airportsearch_unnamed_airport"
        static let kilometers: String = "km"
    }
}



