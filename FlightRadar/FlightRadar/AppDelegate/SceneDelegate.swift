//
//  SceneDelegate.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/26/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: Coordinator!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        window.rootViewController = SettingsController(nibName: "SettingsController", bundle: nil)
        self.window = window
        let coordinator = Coordinator(window: window)
        self.coordinator = coordinator
        coordinator.start()
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        coordinator.coreDataService.saveContext()
    }


}
