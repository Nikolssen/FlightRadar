//
//  TabBarView.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/18/21.
//

import SwiftUI

struct TabBarView: View {
    @Binding var selectedTab: Int
    var body: some View {
        HStack(spacing: .zero) {
            TabBarButton(image: Image("map"), index: 0, selectedTab: $selectedTab)
            TabBarButton(image: Image("compass"), index: 1, selectedTab: $selectedTab)
            TabBarButton(image: Image("hourglass"), index: 2, selectedTab: $selectedTab)
            TabBarButton(image: .airport, index: 3, selectedTab: $selectedTab)
        }
        .padding(Constants.paddingValue)
        .background(Color.whiteLiliac)
        .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous))
        .modifier(NeomorphicShadow())
        .padding(.horizontal)
    }
    
    private enum Constants {
        static let paddingValue: CGFloat = 10.0
        static let cornerRadius = 20.0
    }
}


struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(selectedTab: .constant(.zero))
    }
}
