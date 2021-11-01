//
//  NumberFormatter.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/1/21.
//

import Foundation

extension NumberFormatter {
    static var distanceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.roundingMode = .ceiling
        formatter.numberStyle = .decimal
        formatter.alwaysShowsDecimalSeparator = false
        formatter.maximumFractionDigits = 0
        return formatter
    }()
    
    static func round(number: Double) -> String? {
        distanceFormatter.string(for: number) 
    }
}
