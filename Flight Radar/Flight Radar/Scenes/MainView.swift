//
//  MainView.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/18/21.
//

import SwiftUI
import MapKit
struct MainView: View {
    var body: some View {
        TabView {
            Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 50), latitudinalMeters: 30000, longitudinalMeters: 30000)))
                .tabItem{Image("map")}
                .modifier(NavigationBarInTabBarHidden())
            Color.sanMarino
                .tabItem{Image("compass")}
                .modifier(NavigationBarInTabBarHidden())
            Color.manhattan
                .tabItem{Image(systemName: "airplane")}
                .modifier(NavigationBarInTabBarHidden())
        }
        .ignoresSafeArea()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
