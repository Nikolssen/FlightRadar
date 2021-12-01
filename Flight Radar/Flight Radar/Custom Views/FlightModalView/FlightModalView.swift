//
//  ModalInfoView.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/20/21.
//

import SwiftUI

struct FlightModalView: View {
    var viewModel: FlightModalViewViewModel
    var body: some View {
        VStack(spacing: 15) {
            RoundedRectangle(cornerRadius: 1, style: .continuous)
                .frame(width: 80, height: 3, alignment: .center)
                .foregroundColor(.charcoal.opacity(0.5))
                .offset(y: 5)
            FlightView(viewModel: viewModel.flightViewViewModel)
            HStack(spacing: 20) {
                Text(Constants.companyDescription)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(viewModel.company)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .modifier(NeomorphicShadow())
            .font(.oswaldMedium(size: 18))
            .foregroundColor(.charcoal)
            
            HStack(spacing: 20) {
                Text(Constants.departureDescription)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(viewModel.departureDate)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .modifier(NeomorphicShadow())
            .font(.oswaldMedium(size: 18))
            .foregroundColor(.charcoal)
            HStack(spacing: 20) {
                Text(Constants.arrivalDescription)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(viewModel.arrivalDate)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .modifier(NeomorphicShadow())
            .font(.oswaldMedium(size: 18))
            .foregroundColor(.charcoal)
        }
        .padding(.horizontal, 50)
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color.athensGray)
        .clipShape(CornerRectangle(cornerRadius: 40, byRoundingCorners: [.topLeft, .topRight]))

            
    }
    
    private enum Constants {
        static let arrivalDescription: LocalizedStringKey = "flightinfo_arrival"
        static let departureDescription: LocalizedStringKey = "flightinfo_departure"
        static let companyDescription: LocalizedStringKey = "flightinfo_company"
    }
}

struct FlightModalView_Previews: PreviewProvider {
    static var previews: some View {
        FlightModalView(viewModel: .init(arrivalDate: "18:30 25 Sep", departureDate: "16:00 25 Sep", company: "Ryanair", destinationCode: "VNO", originCode: "WAW", status: "Active", flightTime: "1h 30m"))
    }
}
