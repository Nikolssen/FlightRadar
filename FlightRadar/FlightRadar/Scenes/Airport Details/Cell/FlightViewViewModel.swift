//
//  FlightViewViewModel.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/2/21.
//

import Foundation

protocol FlightViewViewModelling {
    var originCode: String? { get }
    var arrivalCode: String? { get }
    var originName: String? { get }
    var arrivalName: String? { get }
    var time: String? { get }
}

struct FlightViewViewModel: FlightViewViewModelling {
    
    let originCode: String?
    let arrivalCode: String?
    let originName: String?
    let arrivalName: String?
    let time: String?
    
    
}

