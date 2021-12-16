//
//  Service.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 12/16/21.
//

import Foundation
class Service {
    let locationService: LocationService
    let networkService: NetworkService
    
    init(locationService: LocationService, networkService: NetworkService) {
        self.locationService = locationService
        self.networkService = networkService
    }
}
