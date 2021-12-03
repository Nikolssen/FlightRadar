//
//  TicketSearchView.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 12/3/21.
//

import SwiftUI

struct TicketSearchView: View {
    @State var date: Date = Date()
    @State var datePickerHidden: Bool = true
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                HStack {
                    Button("Departure", action: {})
                        .font(.gnuolane(size: 24))
                        .foregroundColor(.charcoal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                HStack {
                    Button("Arrival", action: {})
                        .font(.gnuolane(size: 24))
                        .foregroundColor(.charcoal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                HStack {
                    Button("Date", action: { datePickerHidden.toggle()})
                        .font(.gnuolane(size: 24))
                        .foregroundColor(.charcoal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
            Divider()
//            LazyVGrid() {
//                
//            }
        }
        .background(Color.whiteLiliac)
    }
}

struct TicketSearchView_Previews: PreviewProvider {
    static var previews: some View {
        TicketSearchView()
    }
}
