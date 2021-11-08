//
//  AircraftViewModel.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/8/21.
//

import Foundation
import RxRelay
import RxSwift

protocol AircraftViewModelling {

    var urlDataSource: BehaviorRelay<[URL]> { get }
}

class AircraftViewModel: AircraftViewModelling {
    
    let urlDataSource: BehaviorRelay<[URL]> = .init(value: [])
    
    
}
