//
//  FlightInfoView.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/20/21.
//

import SwiftUI

struct FlightInfoView: View {
    
    struct ViewModel {
        let destination: String
        let destinationCode: String
        let origin: String
        let originCode: String
        let status: String
        let flightTime: String
    }

    let viewModel: FlightInfoView.ViewModel
    
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
            
            Spacer()
            
            Text(viewModel.flightTime)
                .font(.oswaldMedium(size: 18))
                .modifier(NeomorhicShadow())
            Spacer()
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
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color.whiteLiliac)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .modifier(NeomorhicShadow())
    }
}

struct FlightInfoView_Previews: PreviewProvider {
    static var previews: some View {
        FlightInfoView(viewModel: FlightInfoView.ViewModel(destination: "Kyiv", destinationCode: "BPO", origin: "Minsk", originCode: "MSQ", status: "Active", flightTime: "2h 30m"))
    }
}
