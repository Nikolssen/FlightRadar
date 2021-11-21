//
//  TabBarController.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/31/21.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.isTranslucent = false
        tabBar.barTintColor = .athensGray
        tabBar.tintColor = .clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        if #available(iOS 15.0, *) {
           let appearance = UITabBarAppearance()
           appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .athensGray
           
           self.tabBar.standardAppearance = appearance
           self.tabBar.scrollEdgeAppearance = appearance
        }
    }
}
