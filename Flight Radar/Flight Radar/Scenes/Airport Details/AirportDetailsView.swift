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
    @EnvironmentObject var state: AppState
    var body: some View {
        ZStack {
            NavigationLink("Flight", isActive: $viewModel.navigation, destination: {
                if viewModel.navigation, let viewModel = state.airportSearchModels[1] as? FlightDetailsViewModel {
                    FlightDetailsView(viewModel: viewModel)
                }
                else {
                    EmptyView()
                }
            }).opacity(0)
            
            VStack {
                AirportView(viewModel: viewModel.airportViewViewModel, allowFadedAppearence: false)
                    .padding()
                Divider()
                Button("title") {
                    state.selectedIndex = 1
                }
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
                                                let flightViewModel = FlightDetailsViewModel(model: model)
                                                state.airportSearchModels.append(flightViewModel)
                                                viewModel.navigation = true
                                            }
                                            
                                            
                                        }
                                        .padding(.horizontal, 20)
                                        .padding(.top, 10)
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
        .onChange(of: viewModel.navigation) {
            if !$0 {
                state.airportSearchModels.remove(at: 1)
            }
        }
        .background(Color.whiteLiliac)
        .navigationTitle(viewModel.airport.value.name ?? "Unnamed airport")
    }
}
