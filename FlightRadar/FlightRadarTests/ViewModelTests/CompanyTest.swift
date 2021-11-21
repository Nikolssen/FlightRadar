//
//  CompanyTest.swift
//  FlightRadarTests
//
//  Created by Ivan Budovich on 11/19/21.
//

import XCTest
@testable import FlightRadar

final class CompanyTest: XCTestCase {
    var viewModel: CompanyViewModel!
    var coordinator: MockCompanyCoordinator!
    var service: MockService!
    
    override func setUp() {
        coordinator = .init()
        
        service = .init()
        
        guard let url = Bundle.init(for: CompanyTest.self).url(forResource: "company", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return  }
        
        (service.networkService as? MockNetworkService)?.sourceJSON = data
        
        viewModel = .init(coordinator: coordinator, service: service, iataCode: "FR")
    }
    
    func testFail() throws {
        let coordinator = MockCompanyCoordinator()
        let service = MockService()
        
        let nilVM = CompanyViewModel(coordinator: coordinator, service: service, iataCode: "FR")
        nilVM.startRelay.accept(true)
        
        let expectation = XCTestExpectation(description: "Error")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(coordinator.didPopController)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.5)
    }
    
    func testGeneral() throws {
        guard let viewModel = viewModel, let coordinator = coordinator else {
            XCTFail()
            return
        }
        viewModel.startRelay.accept(true)
        let expectation = XCTestExpectation(description: "General Methods")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(viewModel.hasLink)
            XCTAssertEqual(viewModel.iataCode, "FR")
            XCTAssertEqual(viewModel.icaoCode, "RYR")
            XCTAssertTrue(viewModel.isLowcostCarrier)
            viewModel.openLinkRelay.accept(Void())
            XCTAssertTrue(coordinator.didOpenURL)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.5)
    }
}
