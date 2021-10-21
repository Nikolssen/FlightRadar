//
//  AirportGetModel.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/21/21.
//

import Foundation

struct AirportTextGetModel: Encodable {
    let q: String
}

struct AirportLocationGetModel: Encodable {
    let lat: Double
    let lon: Double
    let limit: Int = 10
    let radiusKm: Int = 100
}
