//
//  LocationManager.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/21/21.
//

import Foundation
import CoreLocation

class LocationManager {
    private lazy var manager = CLLocationManager()
    
    var currentLocation: CLLocationCoordinate2D? {
        manager.location?.coordinate
    }
    
    func distance(from coordinates: CLLocationCoordinate2D) -> Double? {
        manager.location?.distance(from: CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude))
    }
}
