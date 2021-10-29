//
//  Coordinator.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/29/21.
//

import UIKit
import RxSwift

class Coordinator {
    private let window: UIWindow
    private let services: Services = Service()
    
    init(window: UIWindow) {
        self.window = window
    }
}
