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
            TabBarContainerView()
                .environmentObject(router)
        }
    }
}
