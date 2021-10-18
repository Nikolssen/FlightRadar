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
                NavigationLink(destination:
                                MainView()
                                .navigationBarTitle("", displayMode: .inline)
                                .navigationBarBackButtonHidden(true)
                                .navigationBarHidden(true)
                                .edgesIgnoringSafeArea([.top, .bottom]),
                               tag: 1,
                               selection: $transitionIndex) {
                    EmptyView()
                }
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
                    Button(action: { transitionIndex = 1 }) {
                        Text(Constants.continueMessage)
                    }
                    .buttonStyle(SolidButtonStyle())
                    
                }
                .padding(10)
            }
            .navigationBarHidden(true)
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
