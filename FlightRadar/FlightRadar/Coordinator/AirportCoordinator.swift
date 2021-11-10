//
//  AirportCoordinator.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/29/21.
//

import RxSwift
import RxRelay
import UIKit

final class AirportCoordinator: Coordinator, AirportSearchCoordinator, AirportDetailsCoordinator, ErrorHandler {
    
    let flightOnMapRelay: PublishRelay<FlightResponseModel.Data> = .init()
    let airportDetailsRelay: PublishRelay<AirportModel> = .init()
    let flightDetailsRelay: PublishRelay<FlightResponseModel.Data> = .init()
    let errorHandlerRelay: PublishRelay<Error> = .init()
    
    private let rootViewController: UINavigationController
    private let service: Services
    private let disposeBag: DisposeBag = .init()
    
    init(rootViewController: UINavigationController, service: Services) {
        self.rootViewController = rootViewController
        self.service = service
        rootViewController.tabBarItem.selectedImage = .airports?.withTintColor(.black).withRenderingMode(.alwaysOriginal)
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

        return controller
    }
    
    
    
    
    private enum Constants {
        static let airportSearchNibName: String = "AirportSearchController"
        static let airportDetailsNibName: String = "AirportDetailsController"
        static let flightControllerNibName: String = "FlightController"
    }
}

