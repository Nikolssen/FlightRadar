//
//  ModalInfoView.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/20/21.
//

import SwiftUI

struct ModalInfoView: View {
    var body: some View {
        VStack(spacing: 10) {
            RoundedRectangle(cornerRadius: 1, style: .continuous)
                .frame(width: 50, height: 3, alignment: .center)
                .foregroundColor(.charcoal.opacity(0.5))
            FlightInfoView(viewModel: FlightInfoViewModel(destination: "Kyiv", destinationCode: "BPO", origin: "Minsk", originCode: "MSQ", status: "Active", flightTime: "2h 30m"))
            HStack(spacing: 20) {
                Text("Company")
                    .frame(alignment: .leading)
                Text("Belavia")
                    .frame(alignment: .trailing)
            }
            .modifier(NeomorhicShadow())
            .font(.oswaldMedium(size: 18))
            .foregroundColor(.charcoal)
            
            HStack(spacing: 20) {
                Text("Departure")
                    .frame(alignment: .leading)
                Text("Belavia")
                    .frame(alignment: .trailing)
            }
            .modifier(NeomorhicShadow())
            .font(.oswaldMedium(size: 18))
            .foregroundColor(.charcoal)
            HStack(spacing: 20) {
                Text("Arrival")
                    .frame(alignment: .leading)
                Text("Belavia")
                    .frame(alignment: .trailing)
            }
            .modifier(NeomorhicShadow())
            .font(.oswaldMedium(size: 18))
            .foregroundColor(.charcoal)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color.athensGray)
        .clipShape(CornerRectangle(cornerRadius: 30, byRoundingCorners: [.topLeft, .topRight]))
        .padding()

            
    }
}

struct ModalInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ModalInfoView()
    }
}
