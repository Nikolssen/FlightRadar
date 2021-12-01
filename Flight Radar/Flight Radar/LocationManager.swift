//
//  LocationManager.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/21/21.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject, CLLocationManagerDelegate {
    private var statusCallback: ((CLAuthorizationStatus) -> Void)?
    private lazy var manager = CLLocationManager()
    
    override init() {
        super.init()
        requestLocationAuthorization()
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
    
    private func requestLocationAuthorization() {
        guard CLLocationManager.authorizationStatus() == .notDetermined else {
            manager.startUpdatingLocation()
            return }
        
        if #available(iOS 13.4, *) {
            self.statusCallback = { [weak self] status in
                if status == .authorizedWhenInUse {
                    self?.manager.requestAlwaysAuthorization()
                }
            }
            self.manager.requestWhenInUseAuthorization()
        } else {
            self.manager.requestAlwaysAuthorization()
        }
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            statusCallback?(status)
            manager.startUpdatingLocation()
        }
    }
}

extension CLLocationCoordinate2D {
    var areCoordinatesValid: Bool {
        (-90...90).contains(Int(latitude)) && (-180...180).contains(Int(longitude))
    }
}
