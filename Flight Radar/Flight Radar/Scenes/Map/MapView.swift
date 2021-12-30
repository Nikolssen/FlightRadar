//
//  MapView.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/22/21.
//

import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var viewModel: MapViewModel
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: .constant(MKCoordinateRegion(center: .init(latitude: 50, longitude: 50), span: .init(latitudeDelta: 2, longitudeDelta: 2))))
                .edgesIgnoringSafeArea(.all)
            if let modalViewModel = viewModel.flightModalViewModel {
                VStack {
                    Spacer()
                    FlightModalView(viewModel: modalViewModel)
                        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height / 2, alignment: .bottom)
                }
            }
        }
            
    }
}

struct MapView_Previews: PreviewProvider {
    static var vm: MapViewModel = {
      let mapVM = MapViewModel()
        mapVM.flightInfo = .init(flightStatus: "", departure: .init(airport: "RIX", iata: "RXI", time: ""), arrival: .init(airport: "FRa", iata: "BRA", time: "nil"), airline: .init(name: "RE", iata: "RE", icao: "RE"), aircraft: nil, live: .init(latitude: 40, longitude: 40, altitude: 1000, direction: 12))
        return mapVM
    }()
    static var previews: some View {
        MapView(viewModel: vm)
    }
}
