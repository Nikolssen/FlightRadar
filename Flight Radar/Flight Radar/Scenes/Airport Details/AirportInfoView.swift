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
    
    var body: some View {
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
            
            switch viewModel.selectedIndex {
            case 0:
                EmptyView()
            case 1, 2:
                if viewModel.shouldShowSpinner {
                    ActivityView(isAnimating: true)
                }
                else {
                    LazyVGrid(columns: [GridItem(.flexible(maximum: .infinity))]) {
                        ForEach(viewModel.dataSource, id: \.index) {
                            flightViewViewModel in
                            FlightView(viewModel: flightViewViewModel)
                        }
                    }
                }
            default:
                EmptyView()
            }
            //Map
            //LazyVGrid
            Spacer()
            
        }
        .background(Color.whiteLiliac)
    }
}

struct AirportDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AirportDetailsView(viewModel: .init(airport: .init(icao: "MSQ", iata: "UUAE", name: "Minsk International", municipalityName: "Minsk", latitude: 35, longitude: 54)))
    }
}
