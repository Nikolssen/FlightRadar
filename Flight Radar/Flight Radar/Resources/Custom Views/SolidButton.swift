//
//  SolidButton.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/14/21.
//

import SwiftUI

struct SolidButton: View {
    
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
        }.buttonStyle(SolidButtonStyle())
    }
}

struct SolidButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.oswaldRegular(size: 20))
            .foregroundColor(.whiteLiliac)
            .frame(width: UIScreen.main.bounds.width - 60, height: 50, alignment: .center)
            .background(configuration.isPressed ? Color.sanMarino.opacity(0.8) : Color.sanMarino)
            .clipShape(Capsule(style: .continuous))
            .shadow(color: Color.charcoal.opacity(0.5), radius: 5, x: 0, y: 5)
    }
}
