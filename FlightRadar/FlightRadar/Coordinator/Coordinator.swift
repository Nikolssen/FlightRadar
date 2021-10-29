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
    
    func start() {
        
    }
    
    init(window: UIWindow) {
        self.window = window
    }
}
