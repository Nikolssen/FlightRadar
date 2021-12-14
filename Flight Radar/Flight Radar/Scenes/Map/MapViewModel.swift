//
//  MapViewModel.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 12/14/21.
//

import Foundation
import UIKit

class MapViewModel {
    var flightInfo: FlightResponseModel.Data?
    var flightViewViewModel: FlightModalViewViewModel? {
        if let flightInfo = flightInfo {
            return .init(flightInfo: flightInfo)
        }
        return nil
    }
}
