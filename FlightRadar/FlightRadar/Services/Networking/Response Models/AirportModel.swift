//
//  AirportModel.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/21/21.
//

import Foundation
struct AirportModel: Decodable {
    
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
