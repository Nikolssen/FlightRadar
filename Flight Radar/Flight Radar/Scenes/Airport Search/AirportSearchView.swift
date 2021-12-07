//
//  SearchView.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/19/21.
//

import SwiftUI

struct AirportSearchView: View {
    @ObservedObject var viewModel: AirportSearchViewModel
    @State var navigation: Bool = false
    let column = [GridItem(.flexible(maximum: .infinity))]
    
    var body: some View {
        ZStack {
            NavigationLink("Airport", isActive: $navigation, destination: {
                if let index = viewModel.selectedIndex, viewModel.airports.count > index { AirportDetailsView(viewModel: .init(airport: viewModel.airports[index])) }
                else {
                    EmptyView() }
            }).opacity(0)
            
            
            Color.athensGray
                .ignoresSafeArea()
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    SearchField(text: $viewModel.searchText, placeholder: Constants.placeholder)
                        .padding(.top)
                    HStack {
                        Spacer()
                        Button(viewModel.buttonTitle) {
                            viewModel.buttonAction.send(Void()) }
                        .padding(.trailing, 15)
                        .font(.gnuolane(size: 20))
                        .foregroundColor(.sanMarino)
                    }
                }
                Divider()
                if viewModel.shouldShowSpinner {
                    Spacer()
                    ActivityView()
                    Spacer()
                }
                else {
                    ScrollView{
                        LazyVGrid(columns: column, alignment: .center, spacing: 20) {
                            ForEach(viewModel.airportViewModels, id: \.index) { cellModel in
                                
                                AirportView(viewModel: cellModel, allowFadedAppearence: true)
                                    .onTapGesture {
                                        viewModel.selectedIndex = cellModel.index
                                        navigation = true
                                    }
                            }
                        }
                        .padding()
                    }
                }
            }
            .padding(.top)
        }
    }
}

private extension AirportSearchView {
    enum Constants {
        static let placeholder: LocalizedStringKey = "airportsearch_placeholder"
    }
}
