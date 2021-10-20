//
//  SearchField.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/19/21.
//

import SwiftUI

struct SearchField: View {
    @Binding var text: String
    @Binding var placeholder: String
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.sanMarino.opacity(0.5))
            PackedTextField(text: $text, placeholder: $placeholder)
                .foregroundColor(.sanMarino)
                .font(.gnuolane(size: 26))
                .modifier(AccentColor(color: .sanMarino))
        }
            .padding()
            .background(Color.whiteLiliac)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .padding()


    }
}

struct SearchField_Previews: PreviewProvider {
    static var previews: some View {
            SearchField(text: .constant("SearchValue"), placeholder: .constant("SomeValue"))
        
    }
}


struct PackedTextField: View {
    @Binding var text: String
    @Binding var placeholder: String
    
    var body: some View {
        if #available(iOS 15.0, *) {
            TextField(placeholder, text: $text, prompt: Text(placeholder))
        } else {
            TextField(placeholder, text: $text)
        }
    }
}