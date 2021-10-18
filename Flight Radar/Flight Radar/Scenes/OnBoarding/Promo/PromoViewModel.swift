//
//  PromoViewModel.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/18/21.
//

import SwiftUI

struct PromoViewModel: Identifiable {
    var id: Int
    
    let headerText: LocalizedStringKey
    let image: Image
    let bottomText: LocalizedStringKey
}
