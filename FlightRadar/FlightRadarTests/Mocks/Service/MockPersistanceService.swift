//
//  MockPersistanceService.swift
//  FlightRadarTests
//
//  Created by Ivan Budovich on 11/16/21.
//

import Foundation
import RxSwift

@testable import FlightRadar

final class MockPersistanceService: PersistanceService {
    
    private var airports: [AirportModel] = []
    var didFetchAirports: Bool = false
    var didAddAirport: Bool = false
    var didCheckForFavorite: Bool = false
    var returnsError: Bool = false
    var didRemoveAirport: Bool = false
    
    func add(airport: AirportModel) {
        didAddAirport = true
        airports.append(airport)
    }
    
    func fetchAirports() -> Single<[AirportModel]> {
        didFetchAirports = true
        if returnsError {
            return .error(NSError(domain: "Error", code: 123, userInfo: [:]))
        }
        else {
            return .just(airports)
        }
    }
    
    required init(containerName: String) {
        
    }
    
    func isFavorite(airport: AirportModel) -> Bool {
        didCheckForFavorite = true
        return airports.contains(where: { $0.iata == airport.iata })
    }
    
    func remove(airport: AirportModel) {
        didRemoveAirport = true
        airports.removeAll(where: { $0.iata == airport.iata })
    }
    
}
