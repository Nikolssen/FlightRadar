//
//  SearchView.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/19/21.
//

import SwiftUI

struct SearchView: View {
    @State private var text: String = ""
    @State private var placeholder: String = "Airport code or name"
    let column = [GridItem(.flexible(maximum: .infinity))]
    
    var body: some View {
        ZStack {
            
            Color.athensGray
                .ignoresSafeArea()
            VStack {
                SearchField(text: $text, placeholder: $placeholder)
                    .padding(.top)
                ScrollView{
                    LazyVGrid(columns: column, alignment: .center, spacing: 20) {
                        
                    }
                    .padding()
                }
            }
            .modifier(HidesKeyboardOnTap())
            
        }
        
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
