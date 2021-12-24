//
//  FlightDetailsView.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 12/7/21.
//

import SwiftUI

struct FlightDetailsView: View {
    @ObservedObject var viewModel: FlightDetailsViewModel
    @EnvironmentObject var router: Router
    var body: some View {
        ZStack {
            NavigationLink("Company", isActive: $viewModel.companyNavigation, destination: {
                if viewModel.companyNavigation, let viewModel = router.companyDetailsViewModel {
                    CompanyDetailsView(viewModel: viewModel)
                }
                else {
                    EmptyView()
                }
            })
            NavigationLink("Aircraft", isActive: $viewModel.aircraftNavigation, destination: {
                if viewModel.aircraftNavigation, let viewModel = router.aircraftDetailsViewModel {
                    AircraftDetailsView(viewModel: viewModel)
                }
                else {
                    EmptyView()
                }
            })
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
                    if viewModel.isCompanyAvailable {
                        Button(action: {
                            if let code = viewModel.companyCode {
                                router.companyDetailsViewModel(code: code)
                                viewModel.companyNavigation = true
                            }
                             }) {
                            Text(Constants.companyButtonDescription)
                        }
                        .buttonStyle(SolidButtonStyle())
                        .padding(.horizontal, 10)
                    }
                    
                    if viewModel.isAircraftAvailable {
                        Button(action: {
                            if let code = viewModel.aircraftCode {
                                router.aircraftDetailsViewModel(code: code)
                                viewModel.aircraftNavigation = true
                            }
                        }) {
                            Text(Constants.aircraftButtonDescription)
                        }
                        .buttonStyle(SolidButtonStyle())
                        .padding(.horizontal, 10)
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color.whiteLiliac)
            .onChange(of: viewModel.aircraftNavigation) {
                if !$0 {
                    router.aircraftDetailsViewModel = nil
                }
            }
            .onChange(of: viewModel.companyNavigation) {
                if !$0 {
                    router.companyDetailsViewModel = nil
                }
            }
        }
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
