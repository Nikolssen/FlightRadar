//
//  AirportSearchTest.swift
//  FlightRadarTests
//
//  Created by Ivan Budovich on 11/16/21.
//

import XCTest
@testable import FlightRadar
import RxSwift

final class AirportSearchTest: XCTestCase {

    var viewModel: AirportSearchViewModel!
    var coordinator: MockAirportSearchCoordinator!
    var service: MockService!
    
    override func setUp() {
        coordinator = MockAirportSearchCoordinator()
        service = MockService()
        viewModel = .init(coordinator: coordinator, service: service)
    }
    
    func testInitialState() throws {
        XCTAssertEqual(viewModel.dataSourceRelay.value.count, 0)
        XCTAssertEqual(viewModel.searchTextRelay.value, "")
    }
    
    func testLocationSearchWithNetworkFailure() throws {
        
        guard let locationService = service.locationService as? MockLocationService,
              let networkService = service.networkService as? MockNetworkService,
              let coordinator = coordinator else {
                  XCTFail()
                  return
              }
        
        viewModel.searchActionRelay.accept(Void())
        
        let locationExpectation = XCTestExpectation(description: "Location")
        let networkingExpectation = XCTestExpectation(description: "Failed Networking")
        let errorHandlingExpectation = XCTestExpectation(description: "Error Handling")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(locationService.didRequestLocation)
            locationExpectation.fulfill()
            XCTAssertTrue(networkService.didPerformRequest)
            networkingExpectation.fulfill()
            XCTAssertTrue(coordinator.didHandleError)
            errorHandlingExpectation.fulfill()
        }
        
        wait(for: [locationExpectation, networkingExpectation, errorHandlingExpectation], timeout: 2)
    }
    
    func testNoLocationSearch() throws {
        guard let locationService = service.locationService as? MockLocationService,
              let networkService = service.networkService as? MockNetworkService,
              let coordinator = coordinator else {
                  XCTFail()
                  return
              }
        locationService.hasLocation = false
        viewModel.searchActionRelay.accept(Void())
        
        let locationExpectation = XCTestExpectation(description: "Location")
        let networkingExpectation = XCTestExpectation(description: "Uncalled Networking")
        let errorHandlingExpectation = XCTestExpectation(description: "Error Handling")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(locationService.didRequestLocation)
            locationExpectation.fulfill()
            XCTAssertFalse(networkService.didPerformRequest)
            networkingExpectation.fulfill()
            XCTAssertTrue(coordinator.didHandleError)
            errorHandlingExpectation.fulfill()
        }
        
        wait(for: [locationExpectation, networkingExpectation, errorHandlingExpectation], timeout: 2)
    }
    
    func testTextSearch() throws {
        guard let url = Bundle.init(for: AirportSearchTest.self).url(forResource: "airports", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            XCTFail("No Data")
            return  }
        guard let networkService = service.networkService as? MockNetworkService,
              let coordinator = coordinator,
              let viewModel = viewModel else {
                  XCTFail()
                  return
              }
        networkService.sourceJSON = data
        viewModel.searchTextRelay.accept("Minsk")
        viewModel.searchActionRelay.accept(Void())
        
        let networkingExpectation = XCTestExpectation(description: "Networking")
        let errorHandlingExpectation = XCTestExpectation(description: "Error Handling")
        let dataSourceExpectation = XCTestExpectation(description: "Datasource")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(networkService.didPerformRequest)
            networkingExpectation.fulfill()
            XCTAssertFalse(coordinator.didHandleError)
            errorHandlingExpectation.fulfill()
            XCTAssertFalse(viewModel.dataSourceRelay.value.isEmpty)
            dataSourceExpectation.fulfill()
        }
        wait(for: [networkingExpectation, errorHandlingExpectation, dataSourceExpectation], timeout: 2)
        
    }
    
    func testFailedTextSearch() throws {
        guard let networkService = service.networkService as? MockNetworkService,
              let coordinator = coordinator else {
                  XCTFail()
                  return
              }
        viewModel.searchTextRelay.accept("Minsk")
        viewModel.searchActionRelay.accept(Void())
        
        let networkingExpectation = XCTestExpectation(description: "Networking")
        let errorHandlingExpectation = XCTestExpectation(description: "Error Handling")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(networkService.didPerformRequest)
            networkingExpectation.fulfill()
            XCTAssertTrue(coordinator.didHandleError)
            errorHandlingExpectation.fulfill()
        }
        wait(for: [networkingExpectation, errorHandlingExpectation], timeout: 2)
        
    }
    
    func testActivityIndicator() throws {
        guard let locationService = service.locationService as? MockLocationService else {
                  XCTFail()
                  return
              }
        var events: [Bool] = []
        let disposeBag = DisposeBag()
        
        viewModel.activityIndicatorRelay
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {
            events.append($0)} )
            .disposed(by: disposeBag)
        
        locationService.hasLocation = true
        viewModel.searchActionRelay.accept(Void())
        
        let locationSearchExpectation = XCTestExpectation(description: "LocationSearch")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(events, [true, false])
            locationSearchExpectation.fulfill()
        }
        wait(for: [locationSearchExpectation], timeout: 2)
        
    }
    
    func testTransition() throws {
        guard let url = Bundle.init(for: AirportSearchTest.self).url(forResource: "airports", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            XCTFail("No Data")
            return  }
        guard let networkService = service.networkService as? MockNetworkService,
              let coordinator = coordinator,
              let viewModel = viewModel else {
                  XCTFail()
                  return
              }
        networkService.sourceJSON = data
        viewModel.searchTextRelay.accept("Minsk")
        viewModel.searchActionRelay.accept(Void())
        
        let dataSourceExpectation = XCTestExpectation(description: "Datasource")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertFalse(viewModel.dataSourceRelay.value.isEmpty)
            viewModel.selectedCellRelay.accept(0)
            XCTAssertTrue(coordinator.didShowDetails)
            dataSourceExpectation.fulfill()
        }
        wait(for: [dataSourceExpectation], timeout: 2)
    }
    

}
