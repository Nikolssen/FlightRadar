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
    
    var currentLocation: CLLocationCoordinate2D? {
        manager.location?.coordinate
    }
    func distance(from coordinates: (latitude: Double, longitude: Double)) -> Double? {
        let coordinate = CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
        return distance(from: coordinate)
    }
    func distance(from coordinates: CLLocationCoordinate2D) -> Double? {
        manager.location?.distance(from: CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude))
    }
}
