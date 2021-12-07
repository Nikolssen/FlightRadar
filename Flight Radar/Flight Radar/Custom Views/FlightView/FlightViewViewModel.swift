//
//  FlightViewViewModel.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 12/1/21.
//

import Foundation

struct FlightViewViewModel {
    internal init(destinationCode: String, originCode: String, status: String, flightTime: String, index: Int = 0) {
        self.destinationCode = destinationCode
        self.originCode = originCode
        self.status = status
        self.flightTime = flightTime
        self.index = index
    }
    
    let destinationCode: String
    let originCode: String
    let status: String
    let flightTime: String
    let index: Int
}
