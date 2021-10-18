//
//  PromoView.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/14/21.
//

import SwiftUI

struct PromoView: View {
    
    let viewModel: PromoViewModel
    
    var body: some View {
        
        VStack {
            Spacer()
            Text(viewModel.headerText)
                .font(.oswaldMedium(size: 36))
                .lineLimit(2)
                .foregroundColor(.charcoal)
            Spacer()
            viewModel.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 80, style: .continuous))
                .padding()
            Spacer()
            Text(viewModel.bottomText)
                .font(.oswaldLight(size: 24))
                .foregroundColor(.charcoal)
            Spacer()
        }
    }
}
