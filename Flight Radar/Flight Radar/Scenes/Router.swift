//
//  Router.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 12/14/21.
//

import Foundation
class Router: ObservableObject {
    private var service: Service
    @Published var selectedIndex = 0
    let airportSearchViewModel: AirportSearchViewModel
    let mapViewModel: MapViewModel = .init()
    var airportSearchModels: [Any] = .init()
    var mapViewModels: [Any] = .init()
    var ticketsViewModels: [Any] = .init()
    
    @discardableResult func airportDetailsViewModel(model: AirportModel) -> AirportDetailsViewModel {
        let viewModel = AirportDetailsViewModel(service: service, airport: model)
        airportSearchModels.removeAll()
        airportSearchModels.append(viewModel)
        return viewModel
    }
    
    var airportDetailsViewModel: AirportDetailsViewModel? {
        if airportSearchModels.count > 0, let viewModel = airportSearchModels[0] as? AirportDetailsViewModel {
            return viewModel
        }
        return nil
    }
    
    @discardableResult func flightDetailsViewModel(model: FlightResponseModel.Data) -> FlightDetailsViewModel {
        let viewModel = FlightDetailsViewModel(model: model)
        if selectedIndex == 0 {
            airportSearchModels.append(viewModel)
        }
        else {
            mapViewModels.append(viewModel)
        }
        return viewModel
    }
    
    var flightDetailsViewModel: FlightDetailsViewModel? {
        if selectedIndex == 0 {
            if airportSearchModels.count > 1, let viewModel = airportSearchModels[1] as? FlightDetailsViewModel {
                return viewModel
            }
        }
        else if selectedIndex == 1 {
            if mapViewModels.count > 0, let viewModel = mapViewModels[0] as? FlightDetailsViewModel {
                return viewModel
            }
        }
        return nil
    }
    
    @discardableResult func companyDetailsViewModel(code: String) -> CompanyDetailsViewModel {
        let viewModel = CompanyDetailsViewModel(service: service, code: code)
        if selectedIndex == 0 {
            airportSearchModels.append(viewModel)
        }
        else {
            mapViewModels.append(viewModel)
        }
        return viewModel
    }
    
    var companyDetailsViewModel: CompanyDetailsViewModel? {
        if selectedIndex == 0 {
            if airportSearchModels.count > 2, let viewModel = airportSearchModels[2] as? CompanyDetailsViewModel {
                return viewModel
            }
        }
        else if selectedIndex == 1 {
            if mapViewModels.count > 1, let viewModel = mapViewModels[1] as? CompanyDetailsViewModel {
                return viewModel
            }
        }
        return nil
    }
    
    var aircraftDetailsViewModel: AircraftDetailsViewModel? {
        if selectedIndex == 0 {
            if airportSearchModels.count > 2, let viewModel = airportSearchModels[2] as? AircraftDetailsViewModel {
                return viewModel
            }
        }
        else if selectedIndex == 1 {
            if mapViewModels.count > 1, let viewModel = mapViewModels[1] as? AircraftDetailsViewModel {
                return viewModel
            }
        }
        return nil
    }
    
    @discardableResult func aircraftDetailsViewModel(code: String) -> AircraftDetailsViewModel {
        let viewModel = AircraftDetailsViewModel(service: service, code: code)
        if selectedIndex == 0 {
            airportSearchModels.append(viewModel)
        }
        else {
            mapViewModels.append(viewModel)
        }
        return viewModel
    }
    
    func popViewModel() {
        if selectedIndex == 0 {
            _ = airportSearchModels.popLast()
        }
        if selectedIndex == 1 {
            _ = mapViewModels.popLast()
        }
    }
    
    init(service: Service) {
        self.service = service
        airportSearchViewModel = .init(service: service)
    }
}
