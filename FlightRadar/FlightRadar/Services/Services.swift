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
}

class Service: Services {
    var persistanceService: PersistanceService = CoreDataService()
    let networkService: NetworkService = APIService()
}
