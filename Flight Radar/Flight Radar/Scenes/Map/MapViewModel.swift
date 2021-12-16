//
//  MapViewModel.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 12/14/21.
//

import Foundation
import UIKit

class MapViewModel: ObservableObject {
    @Published var flightInfo: FlightResponseModel.Data?
    var flightModalViewModel: FlightModalViewViewModel? {
        if let flightInfo = flightInfo {
            return .init(flightInfo: flightInfo)
        }
        return nil
    }
}
