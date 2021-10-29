//
//  AirportSearchViewModel.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/28/21.
//

import Foundation
import RxSwift
import RxRelay

protocol AirportSearchViewModelling {
    var searchTextRelay: BehaviorRelay<String> { get }
    var searchActionRelay: PublishRelay<Void> { get }
}

struct AirportSearchViewModel: AirportSearchViewModelling {
    
    let searchTextRelay: BehaviorRelay<String> = .init(value: "")
    let searchActionRelay: PublishRelay<Void> = .init()
    
    
}