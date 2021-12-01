//
//  Aircraft.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 11/10/21.
//

import Foundation

struct Aircraft: Decodable {
    let age: Double?
    let firstFlight: String?
    let numberOfEngines: Int?
    let productionLine: String?
    let registration: String?
    let owner: String?
    
    enum CodingKeys: String, CodingKey {
        case age = "ageYears"
        case firstFlight = "firstFlightDate"
        case numberOfEngines = "numEngines"
        case productionLine
        case registration = "reg"
        case owner = "airlineName"
    }
}
