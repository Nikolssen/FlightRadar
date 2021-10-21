//
//  SearchView.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/19/21.
//

import SwiftUI

struct AirportSearchView: View {
    @ObservedObject var viewModel: AirportSearchViewModel
    
    let column = [GridItem(.flexible(maximum: .infinity))]
    
    var body: some View {
        ZStack {
            
            Color.athensGray
                .ignoresSafeArea()
            VStack {
                VStack(spacing: 0) {
                    SearchField(text: $viewModel.searchText, placeholder: Constants.placeholder)
                        .padding(.top)
                    HStack {
                        Spacer()
                        Button(viewModel.buttonTitle, action: {viewModel.buttonAction = Void()})
                            .padding(.trailing, 15)
                            .font(.gnuolane(size: 20))
                            .foregroundColor(.sanMarino)
                            .padding(.top, -10)
                    }
                }
                
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

private extension AirportSearchView {
    enum Constants {
        static let placeholder: LocalizedStringKey = "airportsearch_placeholder"
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        AirportSearchView(viewModel: AirportSearchViewModel())
    }
}