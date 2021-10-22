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
    func genericRequest<ResponseModel: Decodable>(request: APIRequest) -> AnyPublisher<DataResponsePublisher<ResponseModel>.Output, DataResponsePublisher<ResponseModel>.Failure>  {
        return AF.request(request.path, method: .get, parameters: request.parameters, encoding: URLEncoding.queryString, headers: request.headers)
            .cURLDescription {  print($0) }
            .publishDecodable(type: ResponseModel.self, queue: .global(qos: .utility), preprocessor: PassthroughPreprocessor(), decoder: JSONDecoder(), emptyResponseCodes: [], emptyResponseMethods: [])
            .eraseToAnyPublisher()
    }
}


enum APIRequest {
    case allFlights(FlightGetModel)
    case airportByFreeText(AirportTextGetModel)
    case airportByLocation(AirportLocationGetModel)
    case company(CompanyGetModel)
    
    var path: String {
        switch self {
        case .allFlights:
            return "http://api.aviationstack.com/v1/flights"
        case .airportByFreeText:
            return "https://aerodatabox.p.rapidapi.com/airports/search/term"
        case .airportByLocation:
            return "https://aerodatabox.p.rapidapi.com/airports/search/location"
        case .company(_):
            return "https://iata-and-icao-codes.p.rapidapi.com/airline"
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .allFlights:
            return HTTPHeaders([:])
        case .airportByFreeText, .airportByLocation:
            return HTTPHeaders(["x-rapidapi-host" : "aerodatabox.p.rapidapi.com", "x-rapidapi-key": APIKey.rapidApiKey])
        case .company:
            return HTTPHeaders(["x-rapidapi-host" : "iata-and-icao-codes.p.rapidapi.com", "x-rapidapi-key": APIKey.rapidApiKey])
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .allFlights(let flightGetModel):
            return flightGetModel.dictionary ?? [:]
        case .airportByFreeText(let airportTextGetModel):
            return airportTextGetModel.dictionary ?? [:]
        case .airportByLocation(let airportLocationGetModel):
            return airportLocationGetModel.dictionary ?? [:]
        case .company(let companyGetModel):
            return companyGetModel.dictionary ?? [:]
        }
    }
    
}
