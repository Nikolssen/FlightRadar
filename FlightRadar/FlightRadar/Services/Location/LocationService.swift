//
//  LocationService.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/29/21.
//

import Foundation
import CoreLocation

protocol LocationService {
    var currentLocation: CLLocationCoordinate2D? { get }
    func distance(from coordinates: (latitude: Double, longitude: Double)) -> Double?
    func distance(from coordinates: CLLocationCoordinate2D) -> Double?
}
class LocationManager: LocationService {
    
    private lazy var manager = CLLocationManager()
    
    init() {
        manager.startUpdatingLocation()
    }
    
    var currentLocation: CLLocationCoordinate2D? {
        manager.location?.coordinate
    }
    func distance(from coordinates: (latitude: Double, longitude: Double)) -> Double? {
        let coordinate = CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
        return distance(from: coordinate)
    }
    func distance(from coordinates: CLLocationCoordinate2D) -> Double? {
        return coordinates.areCoordinatesValid ? manager.location?.distance(from: CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)) : nil
    }
}

extension CLLocationCoordinate2D {
    var areCoordinatesValid: Bool {
        (-90...90).contains(Int(latitude)) && (-180...180).contains(Int(longitude))
    }
}
