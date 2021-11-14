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
    let viewController: TicketsController
    let service: Services
    
    let showArrivalsRelay:PublishRelay<Void> = .init()
    let showDeparturesRelay: PublishRelay<Void> = .init()
    
    let errorHandlerRelay: PublishRelay<Error> = .init()
    
    func start() { }
    
    init(service: Services) {
        let controller = TicketsController(nibName: Constants.ticketControllerNibName, bundle: nil)
        controller.tabBarItem.selectedImage = .tickets?.withTintColor(.label).withRenderingMode(.alwaysOriginal)
        controller.tabBarItem.image = .tickets?.withTintColor(.charcoal).withRenderingMode(.alwaysOriginal)
        

        self.viewController = controller
        self.service = service
        
        let viewModel = TicketsViewModel(coordinator: self, service: service)
        controller.viewModel = viewModel
    }
    
    
    private func removeModal(controller: UIViewController) {
        controller.willMove(toParent: nil)
        controller.view.removeFromSuperview()
        controller.removeFromParent()
    }
    
    private enum Constants {
        static let ticketControllerNibName: String = "TicketsController"
    }
}
