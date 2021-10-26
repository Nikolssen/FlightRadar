//
//  AirportView.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/20/21.
//

import SwiftUI

struct AirportView: View {
    let viewModel: AirportViewViewModel
    let allowFadedAppearence: Bool
    @State var opacity = 0.0
    var body: some View {
       HStack {
            
            VStack {
                HStack {
                    Text(viewModel.distance)
                        .font(.oswaldMedium(size: 16))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.horizontal, 15)
                }
                HStack {
                    Text(viewModel.name)
                        .font(.gnuolane(size: 24))
                        .lineLimit(4)
                    Spacer()
                    Text(viewModel.abbreviations)
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
        .opacity(opacity)
        .onAppear {
            if allowFadedAppearence {
                withAnimation(.easeIn(duration: 0.4)) {
                    opacity = 1.0
                }
            }
                else {
                    opacity = 1.0
                }
            }
        .onDisappear {
            if allowFadedAppearence {
                withAnimation(.easeOut(duration: 0.4)) {
                    opacity = 0.0
                }
            }
        }
    }
}

struct AirportView_Previews: PreviewProvider {
    static var previews: some View {
        AirportView(viewModel: AirportViewViewModel(distance: "25 km", name: "Minsk International", abbreviations: "MSQ", index: 0), allowFadedAppearence: false)
            .padding(20)
            .background(Color.athensGray)
    }
}
