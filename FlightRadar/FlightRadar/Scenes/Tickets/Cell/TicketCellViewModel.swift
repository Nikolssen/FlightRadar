//
//  TicketCellViewModel.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/12/21.
//

import Foundation
protocol TicketCellViewModelling {
    var date: String { get }
    var company: String { get }
    var price: String { get }
}

struct TicketCellViewModel: TicketCellViewModelling {
    let date: String
    let company: String
    let price: String
}
