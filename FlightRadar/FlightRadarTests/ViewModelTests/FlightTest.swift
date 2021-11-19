//
//  FlightTest.swift
//  FlightRadarTests
//
//  Created by Ivan Budovich on 11/19/21.
//
import XCTest
@testable import FlightRadar


final class FlightTest: XCTestCase {
    
    var valueViewModel: FlightViewModel!
    var nilViewModel: FlightViewModel!
    var coordinator: MockFlightCoordinator!
    
    override func setUp() {
        coordinator = .init()
        
        let nilInfo: FlightResponseModel.Data = .init(flightStatus: nil, departure: .init(airport: nil, iata: nil, time: nil), arrival: .init(airport: nil, iata: nil, time: nil), airline: nil, aircraft: nil, live: nil)
        
        let valueInfo: FlightResponseModel.Data = .init(flightStatus: "active", departure: .init(airport: "NYC", iata: "JFK", time: "2019-12-12T04:20:00+00:00"), arrival: .init(airport: "Kyiv", iata: "BPO", time: "2019-12-12T04:40:00+00:00"), airline: .init(name: "Ryanair", iata: "FR", icao: "RYR"), aircraft: .init(registration: "Boeing 777", iata: nil, icao24: "PH-BXO"), live: nil)
        
        nilViewModel = .init(coordinator: coordinator, flightInfo: nilInfo)
        valueViewModel = .init(coordinator: coordinator, flightInfo: valueInfo)
    }
    
    func testCompany() throws {
        XCTAssertEqual(valueViewModel.company, "Ryanair")
        XCTAssertNil(nilViewModel.company)
        
        XCTAssertTrue(valueViewModel.isCompanyAvailable)
        XCTAssertFalse(nilViewModel.isCompanyAvailable)
        
        valueViewModel.companySelectionRelay.accept(Void())
        XCTAssertTrue(coordinator.didShowCompany)
    }
    
    func testAircraft() throws {
        XCTAssertTrue(valueViewModel.isAircraftAvailable)
        XCTAssertFalse(nilViewModel.isAircraftAvailable)
        
        valueViewModel.aircraftSelectionRelay.accept(Void())
        XCTAssertTrue(coordinator.didShowAircraft)
    }
    
    func testDeparture() throws {
        XCTAssertNil(nilViewModel.departureAirport)
        XCTAssertNil(nilViewModel.departure)
        
        XCTAssertEqual(valueViewModel.departureAirport, "NYC")
        XCTAssertEqual(valueViewModel.departure, "12 Dec, 04:20")
    }
    
    func testArrival() throws {
        XCTAssertNil(nilViewModel.arrivalAirport)
        XCTAssertNil(nilViewModel.arrival)
        
        XCTAssertEqual(valueViewModel.arrivalAirport, "Kyiv")
        XCTAssertEqual(valueViewModel.arrival, "12 Dec, 04:40")
    }
    
    func testFlightViewViewModel() throws {
        let viewModel = valueViewModel.flightViewViewModel
        
        XCTAssertEqual(viewModel.departureCode, "JFK")
        XCTAssertEqual(viewModel.arrivalCode, "BPO")
        XCTAssertEqual(viewModel.time, "0h 20m")
    }
}
