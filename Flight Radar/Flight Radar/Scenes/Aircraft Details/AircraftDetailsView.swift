//
//  AircraftDetailsView.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 12/7/21.
//

import SwiftUI

struct AircraftDetailsView: View {
    @ObservedObject var viewModel: AircraftDetailsViewModel
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            Color.whiteLiliac
            if (viewModel.shouldShowSpinner) {
                VStack {
                Spacer()
                ActivityView()
                Spacer()
                }
            }
            else {
                
                VStack(alignment: .center, spacing: 30) {
                    if let production = viewModel.title {
                        TextLine(label: Constants.productionDescription, text: production)
                    }
                    if let registration = viewModel.registrationNumber {
                        TextLine(label: Constants.aircraftRegistrationDescription, text: registration)
                    }
                    if let age = viewModel.age {
                        TextLine(label: Constants.ageDescription, text: age)
                    }
                    if let numberOfEngines = viewModel.numberOfEngines {
                        TextLine(label: Constants.enginesDescription, text: numberOfEngines)
                    }
                    if let firstFlightDate = viewModel.firstFlightDate {
                        TextLine(label: Constants.firstFlightDescription, text: firstFlightDate)
                    }
                    if let owner = viewModel.owner {
                        TextLine(label: Constants.ownerDescription, text: owner)
                    }
                    
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
        }
        .onReceive(viewModel.$dismissAction, perform: {
            if $0 {
                presentationMode.wrappedValue.dismiss()
            }
        })
    }
    
    private enum Constants {
        static let ownerDescription: LocalizedStringKey = "Owner"
        static let enginesDescription: LocalizedStringKey = "Number of engines"
        static let ageDescription: LocalizedStringKey = "Age"
        static let firstFlightDescription: LocalizedStringKey = "First flight"
        static let aircraftRegistrationDescription: LocalizedStringKey = "Aircraft registration number"
        static let productionDescription: LocalizedStringKey = "Model"
        
    }
}
//
//struct AircraftDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AircraftDetailsView()
//    }
//}
