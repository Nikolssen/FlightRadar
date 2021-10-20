//
//  ModalInfoView.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/20/21.
//

import SwiftUI

struct ModalInfoView: View {
    
//    struct ViewModel {
//
//    }
//
//    let viewModel: ModalInfoView.ViewModel
    
    var body: some View {
        VStack(spacing: 15) {
            RoundedRectangle(cornerRadius: 1, style: .continuous)
                .frame(width: 80, height: 3, alignment: .center)
                .foregroundColor(.charcoal.opacity(0.5))
                .offset(y: 5)
            FlightInfoView(viewModel: .init(destination: "Kyiv", destinationCode: "BPO", origin: "Minsk", originCode: "MSQ", status: "Active", flightTime: "2h 30m"))
            HStack(spacing: 20) {
                Text("Company")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Belavia")
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .modifier(NeomorhicShadow())
            .font(.oswaldMedium(size: 18))
            .foregroundColor(.charcoal)
            
            HStack(spacing: 20) {
                Text("Departure")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Belavia")
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .modifier(NeomorhicShadow())
            .font(.oswaldMedium(size: 18))
            .foregroundColor(.charcoal)
            HStack(spacing: 20) {
                Text("Arrival")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Belavia")
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .modifier(NeomorhicShadow())
            .font(.oswaldMedium(size: 18))
            .foregroundColor(.charcoal)
        }
        .padding(.horizontal, 50)
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color.athensGray)
        .clipShape(CornerRectangle(cornerRadius: 40, byRoundingCorners: [.topLeft, .topRight]))

            
    }
}

struct ModalInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ModalInfoView()
    }
}
