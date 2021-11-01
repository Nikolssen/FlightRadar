//
//  AirportCoordinator.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/29/21.
//

import RxSwift
import RxRelay
import UIKit

class AirportCoordinator: Coordinator, AirportSearchCoordinator {
    
    let airportDetailsRelay: PublishRelay<AirportModel> = .init()
    
    let rootViewController: UINavigationController
    let service: Services
    let disposeBag: DisposeBag = .init()
    
    init(rootViewController: UINavigationController, service: Services) {
        self.rootViewController = rootViewController
        self.service = service
        rootViewController.tabBarItem.selectedImage = .airports?.withTintColor(.black).withRenderingMode(.alwaysOriginal)
        rootViewController.tabBarItem.image = .airports?.withTintColor(.charcoal).withRenderingMode(.alwaysOriginal)
    }

    func start() {
        let controller = self.airportSearchController
        rootViewController.setNavigationBarHidden(true, animated: false)
        rootViewController.setViewControllers([controller], animated: false)
    }

    private var airportSearchController: AirportSearchController {
        let controller = AirportSearchController(nibName: "AirportSearchController", bundle: nil)
        let viewModel = AirportSearchViewModel(coordinator: self, service: service)
        controller.viewModel = viewModel
        return controller
    }
    
    private func airportDetailsController(model: AirportModel) -> UIViewController {
        return UIViewController()
    }
}
