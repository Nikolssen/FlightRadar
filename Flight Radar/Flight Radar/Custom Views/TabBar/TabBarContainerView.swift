//
//  TabBarContainerView.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 12/1/21.
//

import SwiftUI

struct TabBarContainerView: View {
    @Binding var selectedTab: Int
    var body: some View {
        VStack {
            switch selectedTab {
            case 0:
                AirportSearchView(viewModel: AirportSearchViewModel())
            case 1:
                MapView()
            case 2:
                Color.sanMarino
            case 3:
                ActivityView()
            default:
                EmptyView()
            }
            Divider()
            TabBarView(selectedTab: $selectedTab)
        }

    }
}

struct TabBarContainerView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarContainerView(selectedTab: .constant(0))
    }
}
