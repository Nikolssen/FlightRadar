//
//  FlightViewViewModel.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/2/21.
//

import Foundation

protocol FlightViewViewModelling {
    var departureCode: String? { get }
    var arrivalCode: String? { get }
    var time: String? { get }
}

struct FlightViewViewModel: FlightViewViewModelling {
    
    let departureCode: String?
    let arrivalCode: String?
    let time: String?
    
}

