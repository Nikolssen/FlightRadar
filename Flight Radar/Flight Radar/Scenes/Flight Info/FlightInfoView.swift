//
//  FlightInfoView.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 12/7/21.
//

import SwiftUI

struct FlightInfoScreenView: View {
    var viewModel: FlightInfoViewModel
    var body: some View {
        VStack(spacing: 30) {
            FlightView(viewModel: viewModel.flightViewViewModel)
            if let company = viewModel.company {
                TextLine(label: Constants.companyDesciption, text: company)
            }
            if let departure = viewModel.departure {
                TextLine(label: Constants.departureDescription, text: departure)
            }
            if let arrival = viewModel.arrival {
                TextLine(label: Constants.arrivalDescription, text: arrival)
            }
            if let departureAirport = viewModel.departureAirport {
                TextLine(label: Constants.departureAirportDescription, text: departureAirport)
            }
            if let arrivalAirport = viewModel.arrivalAirport {
                TextLine(label: Constants.arrivalAirportDescription, text: arrivalAirport)
            }
            
            HStack {
                Button(action: {  }) {
                    Text(Constants.companyButtonDescription)
                }
                .buttonStyle(SolidButtonStyle())
                .padding(.horizontal, 10)
                
                Button(action: { }) {
                    Text(Constants.aircraftButtonDescription)
                }
                .buttonStyle(SolidButtonStyle())
                .padding(.horizontal, 10)
            }
        }
        .padding()
        
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.whiteLiliac)
    }
    
    enum Constants {
        static let companyDesciption: LocalizedStringKey = "Company"
        static let departureDescription: LocalizedStringKey = "Departure"
        static let arrivalDescription: LocalizedStringKey = "Arrival"
        static let departureAirportDescription: LocalizedStringKey = "Departure Airport"
        static let arrivalAirportDescription: LocalizedStringKey = "Arrival Airport"
        static let companyButtonDescription: LocalizedStringKey = "More about this company"
        static let aircraftButtonDescription: LocalizedStringKey = "More about this aircraft"
    }
}

//struct FlightInfoScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        FlightInfoScreenView()
//        
//    }
//}
