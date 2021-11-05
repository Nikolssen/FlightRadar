//
//  MapCoordinator.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/1/21.
//

import UIKit
import RxRelay

final class MapCoordinator: Coordinator {
    
    let rootViewController: UINavigationController
    let service: Services
    
    let showMapRelay: PublishRelay<FlightResponseModel.Data> = .init()
    
    func start() {
        let controller = MapController()
        let viewModel = MapViewModel()
        controller.viewModel = viewModel
        
        rootViewController.setViewControllers([controller], animated: false)
    }


    
    init(rootViewController: UINavigationController, service: Services) {
        self.rootViewController = rootViewController
        self.service = service
        rootViewController.tabBarItem.selectedImage = .map?.withTintColor(.black).withRenderingMode(.alwaysOriginal)
        rootViewController.tabBarItem.image = .map?.withTintColor(.charcoal).withRenderingMode(.alwaysOriginal)
        rootViewController.setNavigationBarHidden(true, animated: false)
        
    
    }
    
}
