//
//  Router.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 12/14/21.
//

import Foundation
class Router: ObservableObject {
    private var service: Service
    var isTabBarHidden: Bool = false
    @Published var selectedIndex: Int = 0
    let airportSearchViewModel: AirportSearchViewModel
    let mapViewModel: MapViewModel
    var airportDetailsViewModel: AirportDetailsViewModel?
    var flightDetailsViewModel: FlightDetailsViewModel?
    var companyDetailsViewModel: CompanyDetailsViewModel?
    var aircraftDetailsViewModel: AircraftDetailsViewModel?
    
    @discardableResult func airportDetailsViewModel(model: AirportModel) -> AirportDetailsViewModel {
        let viewModel = AirportDetailsViewModel(service: service, airport: model)
        airportDetailsViewModel = viewModel
        return viewModel
    }

    
    @discardableResult func flightDetailsViewModel(model: FlightResponseModel.Data) -> FlightDetailsViewModel {
        let viewModel = FlightDetailsViewModel(model: model)
        flightDetailsViewModel = viewModel
        return viewModel
    }

    
    @discardableResult func companyDetailsViewModel(code: String) -> CompanyDetailsViewModel {
        let viewModel = CompanyDetailsViewModel(service: service, code: code)
        companyDetailsViewModel = viewModel
        return viewModel
    }
    
    
    @discardableResult func aircraftDetailsViewModel(code: String) -> AircraftDetailsViewModel {
        let viewModel = AircraftDetailsViewModel(service: service, code: code)
        aircraftDetailsViewModel = viewModel
        return viewModel
    }
    
    init(service: Service) {
        self.service = service
        airportSearchViewModel = .init(service: service)
        mapViewModel = .init()
    }
}
