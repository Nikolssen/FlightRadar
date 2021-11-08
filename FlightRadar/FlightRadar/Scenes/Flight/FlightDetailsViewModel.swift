//
//  FlightDetailsViewModel.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/5/21.
//

import Foundation
import RxRelay
import RxCocoa

protocol FlightDetailsViewModelling {
    init(flightInfo: FlightResponseModel.Data)
    var flightViewViewModel: FlightViewViewModel { get }
    var company: String? { get }
    var departure: String? { get }
    var arrival: String? { get }
    var hideRelay: PublishRelay<Void> { get }
}

final class FlightDetailsViewModel: FlightDetailsViewModelling {

    let hideRelay: PublishRelay<Void> = .init()
    
    private let flightInfoRelay: FlightResponseModel.Data
    let flightViewViewModel: FlightViewViewModel

    var company: String?
    var departure: String?
    var arrival: String?
    
    init(flightInfo: FlightResponseModel.Data) {
        
        flightInfoRelay = flightInfo
        flightViewViewModel = FlightViewViewModel(departureCode: flightInfo.departure?.iata, arrivalCode: flightInfo.arrival?.iata, time: DateFormatter.substract(flightInfo.departure?.time, d2: flightInfo.arrival?.time))
        company = flightInfo.airline?.name
        departure = DateFormatter.extendedDate(from: flightInfo.departure?.time)
        arrival = DateFormatter.extendedDate(from: flightInfo.arrival?.time)
    }
}
