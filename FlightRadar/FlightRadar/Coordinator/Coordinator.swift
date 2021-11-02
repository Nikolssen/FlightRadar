//
//  Coordinator.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/29/21.
//

import UIKit
import RxSwift

protocol Coordinator {
    func start()
}


class ApplicationCoordinator: Coordinator {
    private let window: UIWindow
    private let service: Services = Service()
    private let rootViewController: UITabBarController = TabBarController()
    
    func start() {
        let airportsController = UINavigationController()
        let airportsCoordinator = AirportCoordinator(rootViewController: airportsController, service: service)
        
        
        let mapController = UINavigationController()
        let mapCoordinator = MapCoordinator(rootViewController: mapController, service: service)
        
        let ticketsController = UINavigationController()
        let ticketsCoordinator = TicketsCoordinator(rootViewController: ticketsController, service: service)
        
        airportsCoordinator.start()
        mapCoordinator.start()
        ticketsCoordinator.start()
        
        
        rootViewController.setViewControllers([airportsController, mapController, ticketsController], animated: true)
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
    init(window: UIWindow) {
        self.window = window
        if #available(iOS 15.0, *) {
           let appearance = UITabBarAppearance()
           appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .athensGray
           
           self.rootViewController.tabBar.standardAppearance = appearance
           self.rootViewController.tabBar.scrollEdgeAppearance = appearance
        }
    }
}
