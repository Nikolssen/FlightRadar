//
//  AirportDetailsViewModel.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/22/21.
//

import Foundation
import Combine
import CoreLocation
import MapKit

class AirportDetailsViewModel: ObservableObject {
    private let airport: AirportModel
    @Published var region: MKCoordinateRegion?
    @Published var coordinate: CLLocationCoordinate2D?
    @Published var departures: [FlightResponseModel.Data] = []
    @Published var arrivals: [FlightResponseModel.Data] = []
    @Published var selectedIndex: Int = 0
    
    init(airport: AirportModel) {
        self.airport = airport
        if let location = airport.location{
            let coordinates = CLLocationCoordinate2D(latitude: location.lat, longitude: location.lon)
            region = MKCoordinateRegion(center: coordinates, latitudinalMeters: 200_000, longitudinalMeters: 200_000)
        }
    }
    
}
