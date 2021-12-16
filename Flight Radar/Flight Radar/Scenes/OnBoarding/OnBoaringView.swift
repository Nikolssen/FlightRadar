//
//  OnBoaringView.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/18/21.
//

import SwiftUI

struct OnBoaringView: View {
    
    @State private var selectedIndex: Int = 0
    @State private var transitionIndex: Int? = 0
    
    var viewModel: OnBoardingViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.whiteLiliac
                    .ignoresSafeArea()
                VStack {
                    Text(Constants.welcomeMessage)
                        .font(.oswaldMedium(size: 36))
                        .lineLimit(2)
                        .foregroundColor(.charcoal)
                        .modifier(NeomorphicShadow())
                    
                    TabView(selection: $selectedIndex) {
                        ForEach(viewModel.promoViewModels) {
                            PromoView(viewModel: $0)
                                .tag($0.id)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                    Button(action: { transitionIndex = 1 }) {
                        Text(Constants.getStartedMessage)
                    }
                    .buttonStyle(SolidButtonStyle())
                    .padding(.horizontal, 10)
                    .isHidden(selectedIndex != viewModel.promoViewModels.count - 1)
                    
                }
                .padding(10)
            }
            .navigationBarHidden(true)
        }
    }
}

extension OnBoaringView {
    enum Constants {
        static let welcomeMessage: LocalizedStringKey = "onboard_welcome"
        static let getStartedMessage: LocalizedStringKey = "onboard_get_started"
    }
}


struct OnBoaringView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoaringView(viewModel: OnBoardingViewModel())
        
    }
}
