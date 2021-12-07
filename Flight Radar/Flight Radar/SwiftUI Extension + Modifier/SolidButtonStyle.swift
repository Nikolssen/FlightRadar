//
//  SolidButton.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/14/21.
//

import SwiftUI

struct SolidButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.oswaldRegular(size: 20))
            .foregroundColor(.whiteLiliac)
            .frame(maxWidth: .infinity, idealHeight: 50, alignment: .center)
            .background(configuration.isPressed ? Color.sanMarino.opacity(0.9) : Color.sanMarino)
            .clipShape(Capsule(style: .continuous))
            .shadow(color: Color.charcoal.opacity(0.5), radius: 5, x: 0, y: 5)
    }
}
