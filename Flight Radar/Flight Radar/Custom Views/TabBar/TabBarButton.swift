//
//  TabBarButton.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 12/1/21.
//

import SwiftUI

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
                    .modifier(NeuromorphicInnerShadow(shape: RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous)))
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
