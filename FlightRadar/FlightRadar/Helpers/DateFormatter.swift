//
//  DateFormatter.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/2/21.
//

import Foundation

extension DateFormatter {
    static var decodingFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+00:00"
        return formatter
    }()
    
    static func substract(_ d1: String?, d2: String?) -> String? {
        guard let d1 = d1, let d2 = d2,
              let date1 = DateFormatter.decodingFormatter.date(from: d1),
              let date2 = DateFormatter.decodingFormatter.date(from: d2)
        else { return nil}
        
        let interval = date2.timeIntervalSince(date1)
        let hours =  Int(interval) / 3600
        let minutes = Int(interval) % 3600 / 60
        return "\(hours)h \(minutes)m"
    }
}
