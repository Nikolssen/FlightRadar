//
//  AirportModel.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/21/21.
//

import Foundation
struct AirportModel: Decodable {
    
    init(icao: String?, iata: String?, name: String?, municipalityName: String?, latitude: Double?, longitude: Double?) {
        self.icao = icao
        self.iata = iata
        self.name = name
        self.municipalityName = municipalityName
        if let latitude = latitude, let longitude = longitude {
            self.location = Location(lat: latitude, lon: longitude)
        }
        else {
            self.location = nil
        }
    }
    
    
    struct Location: Decodable {
        let lat: Double
        let lon: Double
    }
    
    let icao: String?
    let iata: String?
    let name: String?
    let municipalityName: String?
    let location: AirportModel.Location?
}

struct AirportResponseModel: Decodable {
    let items: [AirportModel]
}
