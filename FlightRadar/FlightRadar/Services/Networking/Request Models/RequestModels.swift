//
//  RequestModels.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/22/21.
//

import Foundation

struct FlightGetModel: Encodable {
    
    init(departureCode: String? = nil, arrivalCode: String? = nil) {
        self.departureCode = departureCode
        self.arrivalCode = arrivalCode
    }
    
    enum CodingKeys: String, CodingKey {
        case accessKey = "access_key"
        case departureCode = "dep_iata"
        case arrivalCode = "arr_iata"
    }
    
    let accessKey = APIKey.aviationStackKey
    let departureCode: String?
    let arrivalCode: String?
}

struct AirportTextGetModel: Encodable {
    let q: String
    
}

struct AirportLocationGetModel: Encodable {
    let lat: Double
    let lon: Double
    let limit: Int = 10
    let radiusKm: Int = 100
}

struct CompanyGetModel: Encodable {
    let iataCode: String
    
    enum CodingKeys: String, CodingKey {
        case iataCode = "iata_code"
    }
}


extension Encodable {
  var dictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
      return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }?.compactMapValues { $0 }
  }
}
