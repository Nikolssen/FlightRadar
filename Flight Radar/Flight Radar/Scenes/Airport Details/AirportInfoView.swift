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
            //LazyHGrid
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
