//
//  AirportDetailsViewModel.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/2/21.
//

import Foundation
import CoreLocation
import RxSwift
import RxRelay

protocol AirportDetailsViewModelling {
    var mapPointRelay: BehaviorRelay<CLLocationCoordinate2D?> { get }
    var dataSourceRelay: PublishRelay<Void> { get }
}

class AirportDetailsViewModel: AirportDetailsViewModelling {
    let mapPointRelay: BehaviorRelay<CLLocationCoordinate2D?> = .init(value: nil)
    let dataSourceRelay: PublishRelay<Void> = .init()
//    let arrivalRelay: BehaviorRelay<Void> = .init(value: [])
//    let departureRelay: BehaviorRelay<Void> = .init(value: [])
    
}
