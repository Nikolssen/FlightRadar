//
//  SceneDelegate.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/26/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    //var coordinator: Coordinator!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        self.window = window
        //let coordinator = Coordinator(window: window)
        //self.coordinator = coordinator
        //coordinator.start()
        let vc3 = UIViewController()
        vc3.tabBarItem.image = .tickets
        let vc2 = UIViewController()
        vc2.tabBarItem.image = .map
        let vc1 = AirportSearchController(nibName: "AirportSearchController", bundle: nil)
        vc1.tabBarItem.image = .airports
        let tabBarVC = UITabBarController()
        tabBarVC.viewControllers = [vc1, vc2, vc3]
        window.rootViewController = tabBarVC
        window.makeKeyAndVisible()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
       // coordinator.coreDataService.saveContext()
    }


}
