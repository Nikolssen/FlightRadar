//
//  OnBoaringView.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/18/21.
//

import SwiftUI

struct OnBoaringView: View {
    
    @State private var selectedIndex: Int = 0
    
    var viewModel: OnBoardingViewModel
    
    var body: some View {
        ZStack {
            Color.whiteLiliac
                .ignoresSafeArea()
            VStack {
                TabView(selection: $selectedIndex) {
                    ForEach(viewModel.promoViewModels) {
                        PromoView(viewModel: $0)
                            .tag($0.id)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                SolidButton(title: selectedIndex == viewModel.promoViewModels.count - 1 ? Constants.getStartedMessage : Constants.continueMessage, action: {print("Hello")})
                Spacer()
                
            }
        }
    }
}


extension OnBoaringView {
    enum Constants {
        static let continueMessage: String = "Continue"
        static let getStartedMessage: String = "Get started"
    }
}


struct OnBoaringView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoaringView(viewModel: OnBoardingViewModel())
    }
}
