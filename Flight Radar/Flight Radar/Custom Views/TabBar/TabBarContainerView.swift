//
//  TabBarContainerView.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 12/1/21.
//

import SwiftUI

struct TabBarContainerView: View {
    @EnvironmentObject var state: AppState
    var body: some View {
        ZStack {
            Color.whiteLiliac
                .edgesIgnoringSafeArea(.all)
            VStack {
                VStack(spacing: 0) {
                        ZStack {
                            NavigationView {
                                AirportSearchView(viewModel: state.airportSearchViewModel)
                                    .modifier(NavigationBarHidden())
                            }
                            .opacity( state.selectedIndex == 0 ? 1 : 0)
                            
                            MapView()
                                .opacity( state.selectedIndex == 1 ? 1 : 0)
                            TicketSearchView()
                                .opacity( state.selectedIndex == 2 ? 1 : 0)
                        }
                    Divider()
                }
                TabBarView(selectedTab: $state.selectedIndex)
            }
            .padding(.bottom, 30)
        }
    }
}

//struct TabBarContainerView_Previews: PreviewProvider {
//    static var previews: some View {
//        TabBarContainerView()
//    }
//}
