//
//  MainView.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/18/21.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            Color.athensGray
                .tabItem{Image(systemName: "map")}
            Color.sanMarino
                .tabItem{Image(systemName: "clock")}
            Color.manhattan
                .tabItem{Image(systemName: "airplane")}
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
