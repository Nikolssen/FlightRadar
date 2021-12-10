//
//  NeomorphicShadow.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/20/21.
//

import SwiftUI

struct NeomorphicShadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .charcoal.opacity(0.4), radius: 4, x: 5, y: 5)
            .shadow(color: .white.opacity(0.8), radius: 4, x: -5, y: -5)
    }
}


struct NeuromorphicInnerShadow<S>: ViewModifier where S : Shape {

    var shape: S
    
    func body(content: Content) -> some View {
        content
            .overlay(
                shape
                    .stroke(Color.whiteLiliac, lineWidth: 4)
                    .shadow(color: Color.charcoal.opacity(0.4), radius: 3, x: 2, y: 2)
                    .clipShape(shape)
                    .shadow(color: .white, radius: 2, x: -1, y: -1)
                    .clipShape(shape)
                )
    }
    
    init(shape: S) {
        self.shape = shape
    }
    
}
