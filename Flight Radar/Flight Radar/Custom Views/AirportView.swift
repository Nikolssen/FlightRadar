//
//  AirportView.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/20/21.
//

import SwiftUI

struct AirportView: View {
    var body: some View {
        HStack {
            
            VStack {
                HStack {
                    Text("25 km")
                        .font(.oswaldMedium(size: 16))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.horizontal, 15)
                }
                HStack {
                    Text("Minsk International Airport of Saint")
                        .font(.gnuolane(size: 24))
                        .lineLimit(4)
                    Spacer()
                    Text("msq")
                        .textCase(.uppercase)
                        .font(.oswaldMedium(size: 20))
                        .frame(alignment: .top)
                        .lineLimit(1)
                    

                }
                .padding(.horizontal, 15)
                .offset(y: -10)
            }
        }
        .foregroundColor(.sanMarino)
        .padding(.top, 5)
        .padding(.bottom, -5)
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color.whiteLiliac)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .modifier(NeomorhicShadow())
    }
}

struct AirportView_Previews: PreviewProvider {
    static var previews: some View {
        AirportView()
            .padding(20)
            .background(Color.athensGray)
    }
}
