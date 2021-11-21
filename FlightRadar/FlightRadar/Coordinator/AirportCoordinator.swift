//
//  AirportCoordinator.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/29/21.
//

import RxSwift
import RxRelay
import UIKit

final class AirportCoordinator: Coordinator, AirportSearchCoordinator, AirportDetailsCoordinator, FlightCoordinator, CompanyCoordinator, AircraftCoordinator, ErrorHandler {
    let  urlRelay: PublishRelay<URL> = .init()
    
    let flightOnMapRelay: PublishRelay<FlightResponseModel.Data> = .init()
    let airportDetailsRelay: PublishRelay<AirportModel> = .init()
    let flightDetailsRelay: PublishRelay<FlightResponseModel.Data> = .init()
    let errorHandlerRelay: PublishRelay<Error> = .init()
    let companySelectionRelay: PublishRelay<String> = .init()
    let aircraftSelectionRelay: PublishRelay<String> = .init()
    let popRelay: PublishRelay<Void> = .init()
    
    private let rootViewController: UINavigationController
    private let service: Services
    private let disposeBag: DisposeBag = .init()
    
    init(rootViewController: UINavigationController, service: Services) {
        self.rootViewController = rootViewController
        self.service = service
        rootViewController.tabBarItem.selectedImage = .airports?.withTintColor(.label).withRenderingMode(.alwaysOriginal)
        rootViewController.tabBarItem.image = .airports?.withTintColor(.charcoal).withRenderingMode(.alwaysOriginal)
        rootViewController.setNavigationBarHidden(true, animated: false)
    }
    
    func start() {
        let controller = self.airportSearchController
        rootViewController.setViewControllers([controller], animated: false)
        
        airportDetailsRelay
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.rootViewController.pushViewController(self.airportDetailsController(model: $0), animated: true)
            })
            .disposed(by: disposeBag)
        
        flightDetailsRelay
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.rootViewController.pushViewController(self.flightDetailsController(model: $0), animated: true)
            })
            .disposed(by: disposeBag)
        
        companySelectionRelay
            .subscribe(onNext: {[weak self] in
                guard let self = self else { return }
                self.rootViewController.pushViewController(self.companyDetailsController(code: $0), animated: true)
            })
            .disposed(by: disposeBag)
        
        aircraftSelectionRelay
            .subscribe(onNext: {[weak self] in
                guard let self = self else { return }
                self.rootViewController.pushViewController(self.aircraftDetailsController(code: $0), animated: true)
            })
            .disposed(by: disposeBag)
        
        popRelay
            .subscribe(onNext: {[weak self] in self?.rootViewController.popViewController(animated: true)})
            .disposed(by: disposeBag)
        
        errorHandlerRelay
            .subscribe(onNext: { [weak self] _ in
                self?.rootViewController.topViewController?
                    .alertControllerBinder.onNext((Constants.warning, Constants.errorMessage))
            })
            .disposed(by: disposeBag)
        
        urlRelay
            .subscribe(onNext: { UIApplication.shared.open($0, options: [:], completionHandler: nil)})
            .disposed(by: disposeBag)
            
    }
    
    private var airportSearchController: AirportSearchController {
        let controller = AirportSearchController(nibName: Constants.airportSearchNibName, bundle: nil)
        let viewModel = AirportSearchViewModel(coordinator: self, service: service)
        controller.viewModel = viewModel
        return controller
    }
    
    private func airportDetailsController(model: AirportModel) -> AirportDetailsController {
        let controller = AirportDetailsController(nibName: Constants.airportDetailsNibName, bundle: nil)
        let viewModel = AirportDetailsViewModel(coodinator: self, service: service, model: model)
        controller.viewModel = viewModel
        return controller
    }
    
    private func flightDetailsController(model: FlightResponseModel.Data) -> FlightController {
        let controller = FlightController(nibName: Constants.flightControllerNibName, bundle: nil)
        let viewModel = FlightViewModel(coordinator: self, flightInfo: model)
        controller.viewModel = viewModel
        return controller
    }
    
    private func companyDetailsController(code: String) -> CompanyController {
        let controller = CompanyController(nibName: Constants.companyControllerNibName, bundle: nil)
        let viewModel = CompanyViewModel(coordinator: self, service: service, iataCode: code)
        controller.viewModel = viewModel
        return controller
    }
    
    private func aircraftDetailsController(code: String) -> AircraftController {
        let controller = AircraftController(nibName: Constants.aircraftControllerNibName, bundle: nil)
        let viewModel = AircraftViewModel(coordinator: self, service: service, registration: code)
        controller.viewModel = viewModel
        return controller
    }
    
    
    
    private enum Constants {
        static let airportSearchNibName: String = "AirportSearchController"
        static let airportDetailsNibName: String = "AirportDetailsController"
        static let flightControllerNibName: String = "FlightController"
        static let companyControllerNibName: String = "CompanyController"
        static let aircraftControllerNibName: String = "AircraftController"
        static let warning: String = "Warning!"
        static let errorMessage: String = "Failed to perform operation"
    }
}

