//
//  TicketsCoordinator.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/1/21.
//

import UIKit
import RxSwift
import RxRelay

final class TicketsCoordinator: Coordinator, ErrorHandler {
    
    let rootViewController: UINavigationController
    let service: Services
    
    let errorHandlerRelay: PublishRelay<Error> = .init()
    
    func start() {
        
        rootViewController.setViewControllers([ticketsController], animated: false)
    }


    
    init(rootViewController: UINavigationController, service: Services) {
        self.rootViewController = rootViewController
        self.service = service
        rootViewController.tabBarItem.selectedImage = .tickets?.withTintColor(.label).withRenderingMode(.alwaysOriginal)
        rootViewController.tabBarItem.image = .tickets?.withTintColor(.charcoal).withRenderingMode(.alwaysOriginal)
        rootViewController.setNavigationBarHidden(true, animated: false)
    }
    
    var ticketsController: TicketsController {
        let controller = TicketsController(nibName: Constants.ticketControllerNibName, bundle: nil)
        let viewModel = TicketsViewModel(coordinator: self, service: service)
        controller.viewModel = viewModel
        return controller
    }
    
    private enum Constants {
        static let ticketControllerNibName: String = "TicketsController"
    }
}
