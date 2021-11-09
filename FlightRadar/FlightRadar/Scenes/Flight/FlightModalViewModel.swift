//
//  FlightModalViewModel.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/5/21.
//

import Foundation
import RxRelay
import RxSwift

protocol FlightModalViewModelling {
    init(flightInfo: FlightResponseModel.Data)
    var flightViewViewModel: FlightViewViewModel { get }
    var company: String? { get }
    var departure: String? { get }
    var arrival: String? { get }
    var hideRelay: PublishRelay<Void> { get }
    var showFullMode: PublishRelay<Void>  { get }
}

final class FlightModalViewModel: FlightModalViewModelling {

    let hideRelay: PublishRelay<Void> = .init()
    let showFullMode: PublishRelay<Void> = .init()
    private let flightInfo: FlightResponseModel.Data
    
    let disposeBag: DisposeBag = .init()
    
    var flightViewViewModel: FlightViewViewModel {
        FlightViewViewModel(departureCode: flightInfo.departure?.iata, arrivalCode: flightInfo.arrival?.iata, time: DateFormatter.substract(flightInfo.departure?.time, d2: flightInfo.arrival?.time))
    }

    var company: String? {
        flightInfo.airline?.name
    }
    var departure: String? {
        DateFormatter.extendedDate(from: flightInfo.departure?.time)
    }
    var arrival: String? {
        DateFormatter.extendedDate(from: flightInfo.arrival?.time)
    }
    
    init(flightInfo: FlightResponseModel.Data) {
        self.flightInfo = flightInfo
    }
    
}
