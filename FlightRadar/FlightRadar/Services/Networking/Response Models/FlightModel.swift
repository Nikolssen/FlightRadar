//
//  FlightModel.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/2/21.
//

import Foundation

struct FlightResponseModel: Decodable {
    struct Pagination: Decodable {
        let limit: Int
        let offset: Int
        let count: Int
        let total: Int
    }
    struct Data: Decodable {
        let flightStatus: String?
        let departure: Location?
        let arrival: Location?
        let airline: Airline?
        let aircraft: Aircraft?
        let live: Live?
        
        enum CodingKeys: String, CodingKey {
            case flightStatus = "flight_status"
            case departure
            case arrival
            case airline
            case aircraft
            case live
        }
    }

    struct Location: Decodable {
        let airport: String?
        let iata: String?
        let time: String
        
        enum CodingKeys: String, CodingKey {
            case time = "estimated"
            case airport
            case iata
        }
    }

    struct Airline: Decodable {
        let name: String
        let iata: String
        let icao: String
    }
    
    struct Flight: Decodable {
        let number: String
    }
    
    struct Aircraft: Decodable {
        let registration: String
        let iata: String
        let icao24: String
    }

    struct Live: Decodable {
        let latitude: Double
        let longitude: Double
        let altitude: Double
        let direction: Double
    }

    let pagination: Pagination
    let data: [FlightResponseModel.Data]

}
