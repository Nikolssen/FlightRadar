//
//  APIRequest.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/29/21.
//

import Foundation
import Alamofire

enum APIRequest {
    case allFlights(FlightGetModel)
    case airportByFreeText(AirportTextGetModel)
    case airportByLocation(AirportLocationGetModel)
    case company(CompanyGetModel)
    case aircraft(icao24: String)
    case aircraftImage(icao24: String)
    
    var path: String {
        switch self {
        case .allFlights:
            return "http://api.aviationstack.com/v1/flights"
        case .airportByFreeText:
            return "https://aerodatabox.p.rapidapi.com/airports/search/term"
        case .airportByLocation(let model):
            return "https://aerodatabox.p.rapidapi.com/airports/search/location/\(model.lat)/\(model.lon)/km/\(model.radiusKm)/\(model.limit)"
        case .company:
            return "https://iata-and-icao-codes.p.rapidapi.com/airline"
        case .aircraft(icao24: let icao):
            return "https://aerodatabox.p.rapidapi.com/aircrafts/icao24/\(icao)"
        case .aircraftImage(icao24: let icao):
            return "https://aerodatabox.p.rapidapi.com/aircrafts/reg/\(icao)/image/beta"
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .allFlights:
            return HTTPHeaders([:])
        case .airportByFreeText, .airportByLocation, .aircraft, .aircraftImage:
            return HTTPHeaders(["x-rapidapi-host" : "aerodatabox.p.rapidapi.com", "x-rapidapi-key": APIKey.rapidApiKey])
        case .company:
            return HTTPHeaders(["x-rapidapi-host" : "iata-and-icao-codes.p.rapidapi.com", "x-rapidapi-key": APIKey.rapidApiKey])
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .allFlights(let flightGetModel):
            return flightGetModel.dictionary ?? [:]
        case .airportByFreeText(let airportTextGetModel):
            return airportTextGetModel.dictionary ?? [:]
        case .airportByLocation, .aircraft, .aircraftImage:
            return nil
        case .company(let companyGetModel):
            return companyGetModel.dictionary ?? [:]
        }
    }
    
}
