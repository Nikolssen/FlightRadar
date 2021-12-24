//
//  Flight_RadarApp.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/14/21.
//

import SwiftUI

@main
struct Flight_RadarApp: App {
    @StateObject var router: Router = .init(service: Service(locationService: LocationManager(), networkService: APIRepository()))
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(router)
        }
    }
    init() {
        UINavigationBar.appearance().backgroundColor = UIColor(.whiteLiliac)
        UINavigationBar.appearance().tintColor = UIColor(.manhattan)
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UIColor(.sanMarino),
            .font: UIFont(name: "Oswald-Medium", size: 18)!
        ]
    }
}
