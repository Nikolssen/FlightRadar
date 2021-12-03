//
//  TabBarContainerView.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 12/1/21.
//

import SwiftUI

struct TabBarContainerView: View {
    @Binding var selectedTab: Int
    var airportSearchViewModel: AirportSearchViewModel = .init()
    var body: some View {
        ZStack {
            Color.whiteLiliac
                .edgesIgnoringSafeArea(.all)
            VStack {
                VStack(spacing: 0) {
                    switch selectedTab {
                    case 0:
                        AirportSearchView(viewModel: airportSearchViewModel)
                    case 1:
                        MapView()
                    case 2:
                        TicketSearchView()
                    default:
                        EmptyView()
                    }
                    Divider()
                }
                TabBarView(selectedTab: $selectedTab)
            }
            .padding(.vertical, 30)
        }
    }
}

struct TabBarContainerView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarContainerView(selectedTab: .constant(0))
    }
}
