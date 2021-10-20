//
//  FlightInfoView.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/20/21.
//

import SwiftUI

struct FlightInfoView: View {
    
    let viewModel: FlightInfoViewModel
    
    var body: some View {
        HStack {
            VStack {
                Text(viewModel.originCode)
                    .font(.oswaldRegular(size: 36))
                Text(viewModel.origin)
                    .font(.oswaldLight(size: 18))
            }
            .padding(5)
            .modifier(NeomorhicShadow())
            Text(viewModel.flightTime)
                .font(.oswaldMedium(size: 18))
                .modifier(NeomorhicShadow())
            VStack {
                Text(viewModel.destinationCode)
                    .font(.oswaldRegular(size: 36))
                Text(viewModel.destination)
                    .font(.oswaldLight(size: 18))
            }
            .padding(5)
            .modifier(NeomorhicShadow())
            
        }
        .foregroundColor(.charcoal)
        .padding(.horizontal, 30)
        .padding(.vertical, 10)
        .background(Color.whiteLiliac)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .modifier(NeomorhicShadow())
    }
}

struct FlightInfoView_Previews: PreviewProvider {
    static var previews: some View {
        FlightInfoView(viewModel: FlightInfoViewModel(destination: "Kyiv", destinationCode: "BPO", origin: "Minsk", originCode: "MSQ", status: "Active", flightTime: "2h 30m"))
    }
}
