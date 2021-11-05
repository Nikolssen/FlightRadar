//
//  FlightDetailsViewModel.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/5/21.
//

import Foundation
import RxRelay

protocol FlightDetailsViewModelling {
    init(flightInfo: FlightResponseModel.Data)
}

final class FlightDetailsViewModel: FlightDetailsViewModelling {
    let flightInfoRelay: BehaviorRelay<FlightResponseModel.Data>
    
    init(flightInfo: FlightResponseModel.Data) {
        flightInfoRelay = .init(value: flightInfo)
    }
}
