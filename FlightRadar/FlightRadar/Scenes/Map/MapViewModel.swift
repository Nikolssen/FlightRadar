//
//  MapViewModel.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/5/21.
//

import Foundation
import RxRelay

protocol MapViewModelling {
    var flightRelay: BehaviorRelay<FlightResponseModel.Live?> { get }
    
}

final class MapViewModel: MapViewModelling {
    let flightRelay: BehaviorRelay<FlightResponseModel.Live?> = .init(value: nil)
}

