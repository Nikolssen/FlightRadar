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
        
        VStack(alignment: .center, spacing: 20) {
            
            Text(viewModel.headerText)
                .font(.oswaldMedium(size: 36))
                .lineLimit(2)
                .foregroundColor(.charcoal)
                .modifier(NeomorhicShadow())
            
            viewModel.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 80, style: .continuous))
                .modifier(NeomorhicShadow())
                .padding()
            
            Text(viewModel.bottomText)
                .font(.oswaldLight(size: 24))
                .foregroundColor(.charcoal)
            
            
        }
        
    }
}
