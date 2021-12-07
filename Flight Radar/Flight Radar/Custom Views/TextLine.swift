//
//  TextLine.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 12/7/21.
//

import SwiftUI

struct TextLine: View {
    var label: LocalizedStringKey
    var text: String
    var body: some View {
        HStack(spacing: 20) {
            Text(label)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(text)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .modifier(NeomorphicShadow())
        .font(.oswaldMedium(size: 18))
        .foregroundColor(.charcoal)
    }
}

struct TextLine_Previews: PreviewProvider {
    static var previews: some View {
        TextLine(label: "He", text: "Te")
    }
    
}
