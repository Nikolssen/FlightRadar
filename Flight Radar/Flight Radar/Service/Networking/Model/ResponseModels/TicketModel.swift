//
//  TicketModel.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 11/14/21.
//

import Foundation

struct TicketModel: Decodable {
    let airlines: String
    let price: Int
    let url: String
    let departureDate: String
    
    enum CodingKeys: String, CodingKey {
        case airlines
        case price
        case url = "detail_url"
        case departureDate = "departure_date"
    }
}

struct TicketResponseModel: Decodable {
    let flights: [TicketModel]
}
