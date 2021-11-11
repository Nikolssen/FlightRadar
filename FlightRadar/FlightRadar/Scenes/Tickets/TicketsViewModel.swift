//
//  TicketsViewModel.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/11/21.
//

import Foundation
import RxSwift
import RxRelay

protocol TicketsViewModelling {
    var activityIndicatorRelay: PublishRelay<Bool> { get }
}

final class TicketsViewModel: TicketsViewModelling {
    let activityIndicatorRelay: PublishRelay<Bool> = .init()
}
