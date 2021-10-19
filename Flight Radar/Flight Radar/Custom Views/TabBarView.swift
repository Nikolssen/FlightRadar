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
        HStack(spacing: 0) {
            TabBarButton(image: Image("map"), index: 0, selectedTab: $selectedTab)
            TabBarButton(image: Image("compass"), index: 1, selectedTab: $selectedTab)
            TabBarButton(image: Image("plane"), index: 2, selectedTab: $selectedTab)
            TabBarButton(image: Image("airport"), index: 3, selectedTab: $selectedTab)
        }
        .padding(10)
        .background(Color.whiteLiliac)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .padding(.horizontal)
        .shadow(color: .charcoal.opacity(0.2), radius: 4, x: 5, y: 5)
        .shadow(color: .white.opacity(0.8), radius: 4, x: -5, y: -5)
        
    }
}


struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(selectedTab: .constant(0))
    }
}

struct TabBarButton: View {
    var image: Image
    let index: Int
    @Binding var selectedTab: Int
    
    var body: some View {
        GeometryReader {
            reader in
            ZStack {
                Color.whiteLiliac
                    
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .frame(width: 35, height: 35, alignment: .center)
                    .shadow(color: .charcoal.opacity(0.4), radius: 4, x: 5, y: 5)
                    .shadow(color: .white.opacity(0.8), radius: 4, x: -5, y: -5)
                    .isHidden(selectedTab == index)
                
                Color.whiteLiliac
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .frame(width: 40, height: 40, alignment: .center)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .stroke(Color.whiteLiliac, lineWidth: 4)
                            .shadow(color: Color.charcoal.opacity(0.4), radius: 3, x: 2, y: 2)
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .shadow(color: .white, radius: 2, x: -1, y: -1)
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    )
                    .isHidden(selectedTab != index)
                
                Button(action: { selectedTab = index }) {
                    image
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: selectedTab != index ? 25 : 23, height:selectedTab != index ? 25 : 23, alignment: .center)

                    
                }
                .buttonStyle(OpaqueButtonStyle())
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(height: 30, alignment: .center)
        }
        .frame(height: 30)
    }
}
