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
                Button(action: {}) {
                    Text(Constants.continueMessage)
                }
                .buttonStyle(SolidButtonStyle())
                Spacer(minLength: 10)
                
            }
        }
    }
}


extension OnBoaringView {
    enum Constants {
        static let continueMessage: LocalizedStringKey = "continue_title"
        static let getStartedMessage: LocalizedStringKey = "get_started_title"
    }
}


struct OnBoaringView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoaringView(viewModel: OnBoardingViewModel())
    }
}
