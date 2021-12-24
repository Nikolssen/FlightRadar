//
//  ContentView.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 12/1/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var state: Router
    
    var body: some View {
        ZStack {
            Color.whiteLiliac
                .edgesIgnoringSafeArea(.all)
            VStack {
                VStack(spacing: 0) {
                    TabView(selection: $state.selectedIndex) {
                        NavigationView {
                            AirportSearchView(viewModel: state.airportSearchViewModel)
                        }
                        .tag(0)
                        MapView(viewModel: state.mapViewModel)
                            .tag(1)
                        TicketSearchView()
                            .tag(2)
                    }
                    Divider()
                    TabBarView(selectedTab: $state.selectedIndex)
                        .padding(.bottom, 20)
                }
            }
        }
    }
    
    init() {
            UITabBar.appearance().isHidden = true
        }
}
