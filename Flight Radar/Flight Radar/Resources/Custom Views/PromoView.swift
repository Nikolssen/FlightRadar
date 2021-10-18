//
//  PromoView.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/14/21.
//

import SwiftUI

struct PromoView: View {
    let headerText: String
    let image: Image
    let bottomText: String
    
    var body: some View {
        
        VStack {
            Spacer()
            Text(headerText)
                .font(.oswaldMedium(size: 36))
                .lineLimit(2)
            Spacer()
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 80, style: .continuous))
                .padding()
            Spacer()
            Text(bottomText)
                .font(.oswaldLight(size: 24))
            Spacer()
        }
    }
}
