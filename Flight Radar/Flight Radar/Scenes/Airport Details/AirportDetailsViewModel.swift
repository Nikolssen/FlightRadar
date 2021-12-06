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
import Alamofire

class AirportDetailsViewModel: ObservableObject {
    private let airport: CurrentValueSubject<AirportModel, Never>
    @Published var region: MKCoordinateRegion!
    @Published var coordinate: CLLocationCoordinate2D?
    @Published var dataSource: [FlightViewViewModel] = []
    private var departures: CurrentValueSubject<[FlightResponseModel.Data]?, Never> = .init(nil)
    private var arrivals: CurrentValueSubject<[FlightResponseModel.Data]?, Never> = .init(nil)
    @Published var selectedIndex: Int
    @Published var selectedFlight: Int?
    @Published var optionCellViewModels: [OptionCellViewModel] = []
    @Published var shouldShowSpinner: Bool = false
    
    var subscriptions: Set<AnyCancellable> = .init()
    
    var airportViewViewModel: AirportViewViewModel {
        AirportViewViewModel(model: airport.value, using: LocationManager(), index: 0)
    }
    init(airport: AirportModel) {
        self.airport.value = airport
        if let location = airport.location{
            let coordinates = CLLocationCoordinate2D(latitude: location.lat, longitude: location.lon)
            region = MKCoordinateRegion(center: coordinates, latitudinalMeters: 200_000, longitudinalMeters: 200_000)
            selectedIndex = 0
            optionCellViewModels = [.init(text: "Map", index: 0), .init(text: "Departure", index: 1), .init(text: "Arrival", index: 2)]
        }
        else {
            selectedIndex = 1
            optionCellViewModels = [.init(text: "Departure", index: 1), .init(text: "Arrival", index: 2)]
        }
        

        $selectedIndex
            .withLatestFrom(departures) { $0 == 1 && $1 == nil }
            .filter { $0 }
            .withLatestFrom(airport) {$1.iata }
            .flatMapLatest { String -> AnyPublisher<AFResult<FlightResponseModel>, Never>
                
                
            }
            
            
    }
    
}
