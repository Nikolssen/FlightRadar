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
                FlightModalView(viewModel: modalViewModel)
                    .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height / 2, alignment: .bottom)
            }
        }
            
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(viewModel: MapViewModel())
    }
}
