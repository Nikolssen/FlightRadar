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
            TabBarButton(image: Image("airport"), index: 3, selectedTab: $selectedTab)
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

struct TabBarButton: View {
    var image: Image
    let index: Int
    @Binding var selectedTab: Int
    
    var body: some View {
        GeometryReader {
            reader in
            ZStack {
                Color.whiteLiliac
                
                    .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous))
                    .frame(width: Constants.externalShadowSize, height: Constants.externalShadowSize, alignment: .center)
                    .modifier(NeomorphicShadow())
                    .opacity(selectedTab == index ? Constants.zeroOpacity : Constants.fullOpacity)
                
                
                Color.whiteLiliac
                    .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous))
                    .frame(width: Constants.innerShadowSide, height: Constants.innerShadowSide, alignment: .center)
                    .modifier(NeomorphicInnerShadow(shape: RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous)))
                    .opacity(selectedTab != index ? Constants.zeroOpacity : Constants.fullOpacity)
                
                
                Button(action: { withAnimation(.easeInOut(duration: Constants.animationDuration)) { selectedTab = index } }) {
                    image
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: selectedTab != index ? Constants.deselectedSide : Constants.selectedSide, height:selectedTab != index ? Constants.deselectedSide : Constants.selectedSide, alignment: .center)
                    
                    
                }
                .buttonStyle(OpaqueButtonStyle())
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(height: Constants.side, alignment: .center)
        }
        .frame(height: Constants.side)
    }
    
    private enum Constants {
        static let selectedSide: CGFloat = 25
        static let deselectedSide: CGFloat = 28
        static let animationDuration: CGFloat = 0.5
        static let externalShadowSize: CGFloat = 35
        static let innerShadowSide: CGFloat = 40
        static let cornerRadius: CGFloat = 10
        static let side: CGFloat = 30
        static let zeroOpacity: CGFloat = 0.0
        static let fullOpacity: CGFloat = 1.0
    }
}
