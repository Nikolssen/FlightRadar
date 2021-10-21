//
//  APIRepository.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/19/21.
//

import Combine
import Alamofire
import CombineExt

class APIRepository {
    
}


enum APIRequest {
    case allFlights
    case airportByFreeText
    case airportByLocation
    
    var path: String {
        switch self {
        case .allFlights:
            return "http://api.aviationstack.com/v1/flights"
        case .airportByFreeText:
            return "https://aerodatabox.p.rapidapi.com/airports/search/term"
        case .airportByLocation:
            return "https://aerodatabox.p.rapidapi.com/airports/search/location"
        }
    }
}
