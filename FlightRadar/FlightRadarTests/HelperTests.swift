//
//  HelperTests.swift
//  FlightRadarTests
//
//  Created by Ivan Budovich on 11/15/21.
//

import XCTest
@testable import FlightRadar

class HelperTests: XCTestCase {
    
    func testNumberFormatter() {
        XCTAssertEqual(NumberFormatter.round(number: 35.4), "35")
        XCTAssertEqual(NumberFormatter.round(number: 28.9), "29")
        XCTAssertEqual(NumberFormatter.round(number: 0.0), "0")
    }
    
    func testISOToExtendedDate() {
        let isoDate = "2021-11-15T13:29:30+00:00"
        let formattedDate = DateFormatter.extendedDate(from: isoDate)
        
        XCTAssertEqual(formattedDate, "15 Nov, 13:29")
        
        XCTAssertNil(DateFormatter.extendedDate(from: nil))
    }
    
    func testEncodeDate() {
        let isoDate = "2021-11-15T13:29:30+00:00"
        let date = DateFormatter.flightFormatter.date(from: isoDate)
        XCTAssertNotNil(date)
        
        guard let date = date else { return }

        let result = DateFormatter.encodeDate(date: date)
        XCTAssertEqual(result, "2021-11-15")
    }
    
    func testDateSubstraction() {
        let isoDate1 = "2021-11-15T13:29:30+00:00"
        let isoDate2 = "2021-11-15T12:29:30+00:00"
        
        XCTAssertEqual(DateFormatter.substract(isoDate2, d2: isoDate1), "1h 0m")
        
        let isoDate3 = "2021-11-15T13:29:30+00:00"
        let isoDate4 = "2021-11-15T12:50:30+00:00"
        
        XCTAssertEqual(DateFormatter.substract(isoDate4, d2: isoDate3), "0h 39m")
        
        let isoDate5 = "2021-11-15T14:29:30+00:00"
        let isoDate6 = "2021-11-15T12:50:30+00:00"
        
        XCTAssertEqual(DateFormatter.substract(isoDate6, d2: isoDate5), "1h 39m")
        
        let isoDate7 = "2021-11-15T14:29:30+00:00"
        let isoDate8 = "2021-11-14T12:50:30+00:00"
        XCTAssertEqual(DateFormatter.substract(isoDate8, d2: isoDate7), "25h 39m")
    }
    
    func testAircraftFormat() {
        let initialDate = "2021-11-15"
        let result = DateFormatter.date(from: initialDate)
        XCTAssertEqual(result, "15.11.2021")
    }

}
