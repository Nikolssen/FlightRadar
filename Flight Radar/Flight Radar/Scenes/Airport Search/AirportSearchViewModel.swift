//
//  AirportSearchViewModel.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/21/21.
//

import Combine
import SwiftUI

class AirportSearchViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    @Published var buttonTitle: LocalizedStringKey = Constants.searchNearestTitle
    @Published var buttonAction: Void = Void()
    
    
    init() {
        $searchText
            .map { $0.isEmpty ? Constants.searchNearestTitle : Constants.searchTitle }
            .removeDuplicates()
            .assign(to: &$buttonTitle)
        
    }
    
    
}

private extension AirportSearchViewModel {
    enum Constants {
        static let searchTitle: LocalizedStringKey = "Search"
        static let searchNearestTitle: LocalizedStringKey = "airportsearch_nearest"
        
    }
}
