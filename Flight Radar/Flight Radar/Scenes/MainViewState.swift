//
//  AppState.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 12/14/21.
//

import Foundation
class AppState: ObservableObject {
    @Published var selectedIndex = 0
    var airportSearchViewModel: AirportSearchViewModel = .init()
    var airportSearchModels: [Any] = .init()
    var mapViewModels: [Any] = .init()
    var ticketsViewModels: [Any] = .init()
}
