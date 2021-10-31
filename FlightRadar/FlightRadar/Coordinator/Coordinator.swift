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
    private let rootViewController: UITabBarController = .init()
    
    func start() {
        let airportsController = UINavigationController()
        let airportsCoordinator = AirportCoordinator(rootViewController: airportsController, service: service)
        airportsCoordinator.start()
        rootViewController.setViewControllers([airportsController], animated: true)
    }
    
    init(window: UIWindow) {
        self.window = window
    }
}
