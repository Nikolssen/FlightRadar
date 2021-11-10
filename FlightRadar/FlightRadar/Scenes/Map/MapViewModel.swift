//
//  MapViewModel.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/5/21.
//

import Foundation
import RxRelay

protocol MapViewModelling {
    var showModalRelay: PublishRelay<Bool> { get }
    
}

final class MapViewModel: MapViewModelling {
    let showModalRelay: PublishRelay<Bool>  = .init()
}

