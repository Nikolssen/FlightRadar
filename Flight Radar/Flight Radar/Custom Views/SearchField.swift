//
//  SearchField.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/19/21.
//

import SwiftUI

struct SearchField: View {
    @Binding var text: String
    var placeholder: LocalizedStringKey
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 26).bold())
                .foregroundColor(.sanMarino)
                .modifier(NeomorphicShadow())
            PackedTextField(text: $text, placeholder: placeholder)
                .foregroundColor(.sanMarino)
                .font(.gnuolane(size: 26))
                .accentColor(.sanMarino)
                .modifier(NeomorphicShadow())
        }
        .padding()
        .background(Color.whiteLiliac)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .modifier(NeomorphicShadow())
        .padding()
        
        
    }
}

struct SearchField_Previews: PreviewProvider {
    static var previews: some View {
        SearchField(text: .constant("SearchValue"), placeholder: "SomeValue")
        
    }
}


struct PackedTextField: View {
    @Binding var text: String
    var placeholder: LocalizedStringKey
    
    var body: some View {
        if #available(iOS 15.0, *) {
            TextField(placeholder, text: $text, prompt: Text(placeholder))
        } else {
            TextField(placeholder, text: $text)
        }
    }
}
