//
//  Coordinator.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/29/21.
//

import UIKit
import RxSwift
import RxRelay

protocol Coordinator {
    func start()
}

protocol ErrorHandler {
    var errorHandlerRelay: PublishRelay<Error> { get }
}

class ApplicationCoordinator: Coordinator {
    private let window: UIWindow
    private let service: Services = Service()
    private let rootViewController: UITabBarController = TabBarController()
    private let disposeBag: DisposeBag = .init()
    func start() {
        let airportsController = UINavigationController()
        let airportsCoordinator = AirportCoordinator(rootViewController: airportsController, service: service)
        
        
        let mapController = UINavigationController()
        let mapCoordinator = MapCoordinator(rootViewController: mapController, service: service)
        
        airportsCoordinator.flightOnMapRelay
            .do(onNext: { [weak self] _ in self?.rootViewController.selectedIndex = 1 })
            .bind(to: mapCoordinator.showModalRelay)
            .disposed(by: disposeBag)
        
        
        let ticketsCoordinator = TicketsCoordinator(service: service)
        let ticketsController = ticketsCoordinator.viewController
                
        airportsCoordinator.start()
        mapCoordinator.start()
        ticketsCoordinator.start()
        
        
        rootViewController.setViewControllers([airportsController, mapController, ticketsController], animated: true)
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
    init(window: UIWindow) {
        self.window = window
    }
}
