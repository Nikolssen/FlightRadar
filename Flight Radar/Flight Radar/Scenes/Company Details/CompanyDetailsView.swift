//
//  CompanyDetailsView.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 12/7/21.
//

import SwiftUI

struct CompanyDetailsView: View {
    @ObservedObject var viewModel: CompanyDetailsViewModel
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.openURL) var openURL
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
                    if let iata = viewModel.details?.iata {
                        TextLine(label: Constants.iataCodeDescription, text: iata)
                    }
                    if let icao = viewModel.details?.icao {
                        TextLine(label: Constants.icaoCodeDescription, text: icao)
                    }
                    if let isLowcoster = viewModel.details?.isLowCostCarrier, isLowcoster {
                        Text(Constants.lowCostCarrierDescription)
                            .font(.oswaldRegular(size: 18))
                            .foregroundColor(.manhattan)
                    }
                    if let url = viewModel.details?.website {
                        Button(action: { openURL(URL(string: url)!) }) {
                            Text(Constants.companyButtonDescription)
                        }
                        .buttonStyle(SolidButtonStyle())
                        .padding(.horizontal, 40)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
            
        }
        .navigationTitle(viewModel.details?.name ?? Constants.defaultTitle)
        .onReceive(viewModel.$dismissAction, perform: {
            if $0 {
                presentationMode.wrappedValue.dismiss()
            }
        })
    }
    
    enum Constants {
        static let companyButtonDescription: LocalizedStringKey = "Visit company page"
        static let iataCodeDescription: LocalizedStringKey = "IATA code"
        static let icaoCodeDescription: LocalizedStringKey = "ICAO code"
        static let lowCostCarrierDescription: LocalizedStringKey = "Lowcost carrier"
        static let defaultTitle: String = "Company"
    }
}

//struct CompanyInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//       // CompanyDetailsView()
//    }
//}
