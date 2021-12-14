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
            
            if let company = viewModel.company {
                TextLine(label: Constants.companyDescription, text: company)
            }
            if let departure = viewModel.departureDate {
                TextLine(label: Constants.departureDescription, text: departure)
            }
            
            if let arrival = viewModel.arrivalDate {
                TextLine(label: Constants.arrivalDescription, text: arrival)
            }

            

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
