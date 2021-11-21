//
//  AircraftTest.swift
//  FlightRadarTests
//
//  Created by Ivan Budovich on 11/21/21.
//

import XCTest
@testable import FlightRadar

final class AircraftTest: XCTestCase {

    var coordinator: MockAircraftCoordinator!
    var viewModel: AircraftViewModel!
    var service: MockService!
    
    override func setUp() {
        service = .init()
        coordinator = .init()
        
        guard let url = Bundle.init(for: AircraftTest.self).url(forResource: "aircraft", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return  }
        
        (service.networkService as? MockNetworkService)?.sourceJSON = data
        
        viewModel = .init(coordinator: coordinator, service: service, registration: "B-KQJ")
    }


    func testFail() throws {
        guard let coordinator = coordinator else { return }
        
        let nilViewModel = AircraftViewModel(coordinator: coordinator, service: MockService(), registration: "B-KQJ")
        
        nilViewModel.startRelay.accept(true)
        let expectation = XCTestExpectation(description: "Error")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(coordinator.didPopController)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.5)
    }

    func testGeneral() throws {
        guard let viewModel = viewModel else {
            XCTFail()
            return
        }
        viewModel.startRelay.accept(true)
        let expectation = XCTestExpectation(description: "General Methods")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(viewModel.age, "8")
            XCTAssertEqual(viewModel.firstFlightDate,"04.10.2013")
            XCTAssertEqual(viewModel.registrationNumber, "B-KQJ")
            XCTAssertEqual(viewModel.owner, "Cathay Pacific")
            XCTAssertEqual(viewModel.numberOfEngines, "2")
            XCTAssertEqual(viewModel.title, "Boeing 777")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.5)
    }
}
