//
//  Services.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/29/21.
//

import Foundation
protocol Services {
    var persistanceService: PersistanceService { get }
    var networkService: NetworkService { get }
    var locationService: LocationService { get }
}

class Service: Services {
    let persistanceService: PersistanceService = CoreDataService(containerName: "FlightRadar")
    let networkService: NetworkService = APIService()
    let locationService: LocationService = LocationManager()
}
