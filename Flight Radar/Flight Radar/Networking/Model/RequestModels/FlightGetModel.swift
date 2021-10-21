//
//  RealFlightGetModel.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/21/21.
//

import Foundation

struct RealFlightGetModel: Encodable {
    enum CodingKeys: String, CodingKey {
        case accessKey = "access_key"
    }
    
    let accessKey = APIKey.aviationStackKey
}
