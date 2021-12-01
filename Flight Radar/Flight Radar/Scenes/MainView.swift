//
//  MainView.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/18/21.
//

import SwiftUI
import MapKit
struct MainView: View {
    @State var selectedTab: Int = 0
    var body: some View {

        ZStack {

            TabBarContainerView(selectedTab: $selectedTab)
                .padding(.bottom, 30)
                
            }
            .background(Color.athensGray)
            .ignoresSafeArea(.container, edges: .bottom)
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
