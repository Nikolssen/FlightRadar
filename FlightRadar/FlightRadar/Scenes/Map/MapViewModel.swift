//
//  MapViewModel.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/5/21.
//

import Foundation
import RxRelay

protocol MapViewModelling {
    var showModelRelay: PublishRelay<Bool> { get }
    
}

final class MapViewModel: MapViewModelling {
    let showModelRelay: PublishRelay<Bool>  = .init()
}

