//
//  MockService.swift
//  FlightRadarTests
//
//  Created by Ivan Budovich on 11/16/21.
//

import Foundation
@testable import FlightRadar

final class MockService: Services {
    
    var persistanceService: PersistanceService = MockPersistanceService(containerName: "")
    
    var networkService: NetworkService = MockNetworkService()
    
    var locationService: LocationService = MockLocationService()
    
}
