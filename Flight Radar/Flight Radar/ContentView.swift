//
//  ContentView.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/14/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.whiteLiliac
                .ignoresSafeArea()
            VStack {
                TabView {
                    PromoView(headerText: "Welcome to Flight Radar!", image: Image("logo"), bottomText: "Your provider to current flights all over the world.")
                    PromoView(headerText: "Welcome to Flight Radar!", image: Image("logo"), bottomText: "Your provider to current flights all over the world.")
                    PromoView(headerText: "Welcome to Flight Radar!", image: Image("logo"), bottomText: "Your provider to current flights all over the world.")
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                SolidButton(title: "Continue", action: {print("Hello")})
                Spacer()
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
