//
//  MainView.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/18/21.
//

import SwiftUI
import MapKit
struct MainView: View {
    @StateObject var state: AppState = .init()
    var body: some View {
            
        TabBarContainerView()
            .environmentObject(state)
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
