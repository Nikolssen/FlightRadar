//
//  Aircraft.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/10/21.
//

import Foundation

struct Aircraft: Decodable {
    let age: Double?
    let firstFlight: String?
    let numberOfSeats: Int?
    let numberOfEngines: Int?
    let productionLine: String?
    let registration: String?
    let icao: String?
    
    enum CodingKeys: String, CodingKey {
        case age = "ageYears"
        case firstFlight = "firstFlightDate"
        case numberOfSeats = "numSeats"
        case numberOfEngines = "numEngines"
        case productionLine
        case registration = "reg"
        case icao = "hexIcao"
    }
}
