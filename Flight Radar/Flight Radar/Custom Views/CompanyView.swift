//
//  CompanyView.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/21/21.
//

import SwiftUI

struct CompanyView: View {
    var body: some View {
        VStack {
            HStack{
                Text("Belavia")
                    .font(.oswaldMedium(size: 18))
                
                Text("BRU/B2")
                .font(.oswaldLight(size: 18))
            }
            Text("Low Cost Carrier")
                .font(.oswaldLight(size: 12))
                .padding(5)
                .background(Color.green.opacity(0.3))
                
                .modifier(NeomorphicInnerShadow(shape: RoundedRectangle(cornerRadius: 10, style: .continuous)))
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            
        }
        .foregroundColor(Color.charcoal)
        .padding(15)
        .background(Color.athensGray)
        .clipShape(Capsule(style: .continuous))
        .modifier(NeomorhicShadow())
        

    }
}

struct CompanyView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyView()
    }
}
