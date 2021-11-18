//
//  MockLocationService.swift
//  FlightRadarTests
//
//  Created by Ivan Budovich on 11/16/21.
//

import Foundation
@testable import FlightRadar
import CoreLocation

class MockLocationService: LocationService {
    
    var hasLocation: Bool = true
    var didRequestDistance: Bool = false
    var didRequestLocation: Bool = false
    var currentLocation: CLLocationCoordinate2D? {
        didRequestLocation = true
        return hasLocation ? CLLocationCoordinate2D(latitude: 0, longitude: 0) : nil
    }
    
    func distance(from coordinates: (latitude: Double, longitude: Double)) -> Double? {
        distance(from: CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude))
    }
    
    func distance(from coordinates: CLLocationCoordinate2D) -> Double? {
        didRequestDistance = true
        return coordinates.areCoordinatesValid ? 200.56 : nil
    }
}
