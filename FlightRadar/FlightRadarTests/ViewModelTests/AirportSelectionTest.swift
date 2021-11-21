//
//  AirportSelectionTest.swift
//  FlightRadarTests
//
//  Created by Ivan Budovich on 11/21/21.
//

import XCTest
@testable import FlightRadar

final class AirportSelectionTest: XCTestCase {

    var coordinator: MockAirportSelectionCoordinator!
    var service: MockService!
    
    override func setUp() {
        service = .init()
        coordinator = .init()
    }
    
    func testEmptyData() {
        guard let persistanceService = service.persistanceService as? MockPersistanceService, let coordinator = coordinator else {
            XCTFail()
            return
        }
        let viewModel: AirportSelectionViewModel = .init(service: service, coordinator: coordinator)
        let expectation = XCTestExpectation(description: "Empty Fetch")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(viewModel.dataSourceRelay.value.isEmpty)
            XCTAssertFalse(coordinator.didHandleError)
            XCTAssertTrue(persistanceService.didFetchAirports)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.5)
    }

    func testPersistanceError() throws {
        guard let persistanceService = service.persistanceService as? MockPersistanceService, let coordinator = coordinator else {
            XCTFail()
            return
        }
        persistanceService.returnsError = true
        let viewModel: AirportSelectionViewModel = .init(service: service, coordinator: coordinator)
        let expectation = XCTestExpectation(description: "Error Fetch")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(viewModel.dataSourceRelay.value.isEmpty)
            XCTAssertTrue(coordinator.didHandleError)
            XCTAssertTrue(persistanceService.didFetchAirports)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.5)
    }
    
    func testFetchAndSelection() throws {
        guard let persistanceService = service.persistanceService as? MockPersistanceService, let coordinator = coordinator
        else {
            XCTFail()
            return
        }
        persistanceService.add(airport: AirportModel(icao: "UMMS", iata: "MSQ", name: "Minsk-2", municipalityName: "Minsk", latitude: 53, longitude: 46))
        persistanceService.add(airport: AirportModel(icao: "UUEE", iata: "SVO", name: "Sheremetyevo", municipalityName: "Moscow", latitude: 50, longitude: 50))
        
        let viewModel: AirportSelectionViewModel = .init(service: service, coordinator: coordinator)
        let expectation = XCTestExpectation(description: "Fetch and Selection")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(viewModel.dataSourceRelay.value.count, 2)
            XCTAssertTrue(persistanceService.didFetchAirports)
            viewModel.selectedIndexRelay.accept(1)
            XCTAssertTrue(coordinator.didSelectAirport)
            XCTAssertEqual(coordinator.airportRelay.value, "SVO")
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 1.5)
    }
    
    func testDismiss() {
        let viewModel: AirportSelectionViewModel = .init(service: service, coordinator: coordinator)
        viewModel.dismissalRelay.accept(Void())
        XCTAssertTrue(coordinator.didDismissModal)
    }

}
