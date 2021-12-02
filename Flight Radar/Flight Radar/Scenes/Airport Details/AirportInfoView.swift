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
//            AirportView()
//                .padding()
            Divider()
            Spacer()
            
        }
        .background(Color.whiteLiliac)
    }
}

struct AirportDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AirportDetailsView()
    }
}
