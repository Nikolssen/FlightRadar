//
//  TicketModel.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/14/21.
//

import Foundation

struct TicketModel {
    struct Carrier {
        let carrierId: Int
        let name: String
    }
    
    struct OutboundLeg {
        let carrierIDs: [Int: Int]
        let departureDate: String
    }
    
    struct Quote {
        let minPrice: Double
        let outboundLeg: OutboundLeg
    }
    
    let carrier: [Carrier]
    let quote: [Quote]
}
