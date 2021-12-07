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
    let airport: CurrentValueSubject<AirportModel, Never>
    @Published var region: MKCoordinateRegion
    @Published var coordinate: CLLocationCoordinate2D?
    @Published var dataSource: [FlightViewViewModel] = []
    private var departures: CurrentValueSubject<[FlightResponseModel.Data]?, Never> = .init(nil)
    private var arrivals: CurrentValueSubject<[FlightResponseModel.Data]?, Never> = .init(nil)
    @Published var selectedIndex: Int
    @Published var selectedFlight: Int?
    @Published var optionCellViewModels: [OptionCellViewModel] = []
    @Published var shouldShowSpinner: Bool = false
    let locationService = LocationManager()
    let networkService = APIRepository()
    var subscriptions: Set<AnyCancellable> = .init()
    
    var airportViewViewModel: AirportViewViewModel {
        AirportViewViewModel(model: airport.value, using: LocationManager(), index: 0)
    }
    init(airport: AirportModel) {
        self.airport = .init(airport)
        if let location = airport.location{
            let coordinates = CLLocationCoordinate2D(latitude: location.lat, longitude: location.lon)
            region = MKCoordinateRegion(center: coordinates, latitudinalMeters: 200_000, longitudinalMeters: 200_000)
            selectedIndex = 0
            optionCellViewModels = [.init(text: "Map", index: 0), .init(text: "Departure", index: 1), .init(text: "Arrival", index: 2)]
        }
        else {
            selectedIndex = 1
            optionCellViewModels = [.init(text: "Departure", index: 1), .init(text: "Arrival", index: 2)]
            region = MKCoordinateRegion(center: .init(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5))
        }
        
        $selectedIndex
            .withLatestFrom(departures) { $0 == 1 && $1 == nil }
            .filter { $0 }
            .withLatestFrom(self.airport)
            .compactMap { $0.iata }
            .handleEvents(receiveOutput: { [weak self] _ in self?.shouldShowSpinner = true})
            .receive(on: DispatchQueue.global(qos: .utility))
            .flatMapLatest { [networkService] code -> AnyPublisher<DataResponsePublisher<FlightResponseModel>.Output, Never>
                in
                networkService.genericRequest(request: .allFlights(FlightGetModel(departureCode: code)))
            }
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { [weak self] _ in self?.shouldShowSpinner = false})
            .sink {
                [weak self]  in
                switch $0.result {
                case .failure(let error):
                    
                    break
                case .success(let values):
                    self?.departures.send(values.data)
                }
            }
            .store(in: &subscriptions)
        $selectedIndex
            .withLatestFrom(arrivals) { $0 == 2 && $1 == nil }
            .filter { $0 }
            .withLatestFrom(self.airport)
            .compactMap { $0.iata }
            .handleEvents(receiveOutput: { [weak self] _ in self?.shouldShowSpinner = true})
            .receive(on: DispatchQueue.global(qos: .utility))
            .flatMapLatest { [networkService] code -> AnyPublisher<DataResponsePublisher<FlightResponseModel>.Output, Never>
                in
                networkService.genericRequest(request: .allFlights(FlightGetModel(arrivalCode: code)))
            }
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { [weak self] _ in self?.shouldShowSpinner = false})
            .sink {
                [weak self]  in
                switch $0.result {
                case .failure(let error):
                    
                    break
                case .success(let values):
                    self?.arrivals.send(values.data)
                }
                
                
                
            }
            .store(in: &subscriptions)
        
        Publishers.CombineLatest.init($selectedIndex, departures)
            .filter { $0.0 == 1}
            .compactMap { $1 }
            .map {
                var newArray: [FlightViewViewModel] = []
                for (index, value) in $0.enumerated() {
                    newArray.append(FlightViewViewModel(destinationCode: value.departure?.iata ?? "", originCode: value.arrival?.iata ?? "", status: value.flightStatus ?? "", flightTime: DateFormatter.substract(value.departure?.time, d2: value.arrival?.time) ?? "", index: index))
                }
                return newArray
            }
            .sink { [weak self] in
                self?.dataSource = $0
                
            }
            .store(in: &subscriptions)
        
        Publishers.CombineLatest.init($selectedIndex, arrivals)
            .filter { $0.0 == 2}
            .compactMap { $1 }
            .map {
                var newArray: [FlightViewViewModel] = []
                for (index, value) in $0.enumerated() {
                    newArray.append(FlightViewViewModel(destinationCode: value.departure?.iata ?? "", originCode: value.arrival?.iata ?? "", status: value.flightStatus ?? "", flightTime: DateFormatter.substract(value.departure?.time, d2: value.arrival?.time) ?? "", index: index))
                }
                return newArray
            }
            .sink { [weak self] in
                self?.dataSource = $0
                
            }
            .store(in: &subscriptions)
    }
}
