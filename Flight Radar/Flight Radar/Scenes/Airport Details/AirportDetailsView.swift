//
//  AirportInfoView.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/22/21.
//

import SwiftUI
import MapKit

struct AirportDetailsView: View {
    @ObservedObject var viewModel: AirportDetailsViewModel
    @EnvironmentObject var router: Router
    var body: some View {
        ZStack {
            NavigationLink("Flight", isActive: $viewModel.navigation, destination: {
                if viewModel.navigation, let viewModel = router.flightDetailsViewModel {
                    FlightDetailsView(viewModel: viewModel)
                }
                else {
                    EmptyView()
                }
            }).opacity(0)
            
            Color.whiteLiliac
                .ignoresSafeArea(.all)
            
            VStack {
                AirportView(viewModel: viewModel.airportViewViewModel, allowFadedAppearence: false)
                    .padding()
                Divider()
                LazyHGrid(rows: [.init(.flexible())], spacing: 40) {
                    ForEach(viewModel.optionCellViewModels, id: \.index) { cellViewModel in
                        OptionCell(viewModel: cellViewModel, isSelected: cellViewModel.index == viewModel.selectedIndex)
                            .onTapGesture {
                                viewModel.selectedIndex = cellViewModel.index
                            }
                    }
                }
                .frame(maxWidth: .infinity ,maxHeight: 30, alignment: .top)
                Divider()
                switch viewModel.selectedIndex {
                case 0:
                    Map(coordinateRegion: $viewModel.region)
                case 1, 2:
                    if viewModel.shouldShowSpinner {
                        Spacer()
                        ActivityView()
                        Spacer()
                    }
                    else {
                        ScrollView{
                            LazyVGrid(columns: [GridItem(.flexible(maximum: .infinity))], spacing: 20) {
                                ForEach(viewModel.dataSource, id: \.index) {
                                    flightViewViewModel in
                                    FlightView(viewModel: flightViewViewModel)
                                        .onTapGesture {
                                            viewModel.selectedFlight = flightViewViewModel.index
                                            if let model = viewModel.selectedModel {
                                                router.flightDetailsViewModel(model: model)
                                                viewModel.navigation = true
                                            }
                                        }
                                        .padding(.horizontal, 20)
                                        .padding(.top, 5)
                                }
                            }
                        }
                    }
                default:
                    EmptyView()
                }
                Spacer()
                
            }
        }
        .background(Color.whiteLiliac)
        .navigationTitle(viewModel.airport.value.name ?? "Unnamed airport")
    }
}
