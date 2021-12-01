//
//  FlightInfoView.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/20/21.
//

import SwiftUI

struct FlightView: View {
    
    let viewModel: FlightViewViewModel
    
    var body: some View {
        HStack {
            Text(viewModel.originCode)
                .font(.oswaldRegular(size: 36))
                .padding(5)
                .modifier(NeomorphicShadow())
            
            Spacer()
            
            Text(viewModel.flightTime)
                .font(.oswaldMedium(size: 18))
                .modifier(NeomorphicShadow())
            Spacer()
            
            Text(viewModel.destinationCode)
                .font(.oswaldRegular(size: 36))
                .padding(5)
                .modifier(NeomorphicShadow())
            
        }
        .foregroundColor(.charcoal)
        .padding(.horizontal, 30)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color.whiteLiliac)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .modifier(NeomorphicShadow())
    }
}

struct FlightView_Previews: PreviewProvider {
    static var previews: some View {
        FlightView(viewModel: FlightViewViewModel(destinationCode: "BPO", originCode: "MSQ", status: "Active", flightTime: "2h 30m"))
    }
}
