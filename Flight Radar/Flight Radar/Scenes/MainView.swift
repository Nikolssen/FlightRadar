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
            
        TabBarContainerView(selectedTab: $selectedTab)                
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
