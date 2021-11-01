//
//  TabBarController.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/31/21.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.isTranslucent = false
        tabBar.barTintColor = .athensGray
        tabBar.tintColor = .clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        var offset: CGFloat = 6.0

        if traitCollection.horizontalSizeClass == .regular {
            offset = 0.0
        }

        if let items = tabBar.items {
            for item in items {
                item.title = nil
                item.imageInsets = UIEdgeInsets(top: offset, left: 0, bottom: -offset, right: 0)
            }
        }
    }
}
