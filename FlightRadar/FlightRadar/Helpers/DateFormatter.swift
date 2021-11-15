//
//  DateFormatter.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/2/21.
//

import Foundation

extension DateFormatter {
    static var flightFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+00:00"
        return formatter
    }()
    
    static var extendedDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM, HH:mm"
        return formatter
    }()
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd:mm:yyyy"
        return formatter
    }()
    
    static var aircraftDecodingFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter
    }()
    
    static var encodingTicketFormatter: DateFormatter  = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        return formatter
    }()
    
    static func substract(_ d1: String?, d2: String?) -> String? {
        guard let d1 = d1, let d2 = d2,
              let date1 = DateFormatter.flightFormatter.date(from: d1),
              let date2 = DateFormatter.flightFormatter.date(from: d2)
        else { return nil}
        
        let interval = date2.timeIntervalSince(date1)
        let hours =  Int(interval) / 3600
        let minutes = Int(interval) % 3600 / 60
        return "\(hours)h \(minutes)m"
    }
    
    static func extendedDate(from: String?) -> String? {
        guard let string = from, let date = flightFormatter.date(from: string) else { return nil }
        return extendedDateFormatter.string(from: date)
    }
    
    static func date(from: String?) -> String? {
        guard let string = from, let date = dateFormatter.date(from: string) else { return nil }
        return aircraftDecodingFormatter.string(from: date)
    }
    
    static func encodeDate(date: Date) -> String {
        encodingTicketFormatter.string(from: date)
    }
}
