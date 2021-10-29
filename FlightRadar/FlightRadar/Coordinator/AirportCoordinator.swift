//
//  AirportCoordinator.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/29/21.
//

import Foundation
import RxSwift
import RxRelay
import UIKit

class AirportCoordinator: Coordinator, AirportSearchCoordinator {
    
    let airportDetailsRelay: PublishRelay<AirportResponseModel> = .init()
    let rootViewController: UINavigationController
    let service: Service
    
    func start() {
        
    }
    
    init(rootViewController: UINavigationController, service: Service) {
        self.rootViewController = rootViewController
        self.service = service
    }
    
    private var airportSearchController: AirportSearchController {
        let controller = AirportSearchController(nibName: "AirportSearchController", bundle: nil)
        let viewModel = AirportSearchViewModel(coordinator: self, service: service)
        controller.viewModel = viewModel
        return controller
    }
    
}
