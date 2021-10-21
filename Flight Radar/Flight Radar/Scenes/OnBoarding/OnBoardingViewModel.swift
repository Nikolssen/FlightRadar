//
//  OnBoardingViewModel.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/18/21.
//

import SwiftUI

struct OnBoardingViewModel {
    
    let promoViewModels = [
        PromoViewModel(id: 0, headerText: "onboard_welcome", image: .logo, bottomText: "onboard_provider"),
        PromoViewModel(id: 1, headerText: "onboard_welcome", image: .logo, bottomText: "onboard_airports"),
        PromoViewModel(id: 2, headerText: "welcome_msg", image: .logo, bottomText: "provider_msg")]
    
}
