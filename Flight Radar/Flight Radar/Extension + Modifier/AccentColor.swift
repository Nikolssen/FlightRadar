//
//  AccentColor.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/20/21.
//

import SwiftUI

struct AccentColor: ViewModifier {
    let color: Color
    
    func body(content: Content) -> some View {
        Group {
            if #available(iOS 15.0, *) {
                content
                    .tint(color)
            }
            else {
                content
                    .accentColor(color)
            }
        }
    }
}
