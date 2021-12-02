//
//  CompanyModel.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/21/21.
//

import Foundation

struct CompanyModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case iata = "iata_code"
        case icao = "icao_code"
        case isLowCostCarrier = "low_cost_carrier"
        case name
        case website
        
    }
    
    let isLowCostCarrier: Bool
    let name: String
    let website: String?
    let iata: String?
    let icao: String
}

