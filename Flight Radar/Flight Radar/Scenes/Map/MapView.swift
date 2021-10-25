//
//  MapView.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/22/21.
//

import SwiftUI
import MapKit

struct MapView: View {
    var body: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(center: .init(latitude: 50, longitude: 50), span: .init(latitudeDelta: 2, longitudeDelta: 2))))
            
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
