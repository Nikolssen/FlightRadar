//
//  RealFlightGetModel.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/21/21.
//

import Foundation

struct RealFlightGetModel: Encodable {
    let accessKey = APIKey.aviationStackKey
}

extension RealFlightGetModel {
    enum CodingKeys: String, CodingKey {
        case accessKey = "access_key"
    }
}
