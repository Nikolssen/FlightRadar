//
//  TicketsCoordinator.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/1/21.
//

import UIKit
class TicketsCoordinator: Coordinator {
    
    let rootViewController: UINavigationController
    let service: Services
    
    func start() {
        let controller = UIViewController()
        rootViewController.setViewControllers([controller], animated: false)
    }


    
    init(rootViewController: UINavigationController, service: Services) {
        self.rootViewController = rootViewController
        self.service = service
        rootViewController.tabBarItem.selectedImage = .tickets?.withTintColor(.black).withRenderingMode(.alwaysOriginal)
        rootViewController.tabBarItem.image = .tickets?.withTintColor(.charcoal).withRenderingMode(.alwaysOriginal)
        rootViewController.setNavigationBarHidden(true, animated: false)
    }
    
}
