//
//  AirportDetailsTest.swift
//  FlightRadarTests
//
//  Created by Ivan Budovich on 11/18/21.
//
import XCTest
import RxSwift
import RxRelay
@testable import FlightRadar

final class AirportDetailsTest: XCTestCase {
    var coordinator: MockAirportDetailsCoordinator!
    var service: MockService!
    var viewModel: AirportDetailsViewModel!
    
    override func setUp() {
        coordinator = MockAirportDetailsCoordinator()
        service = MockService()
        let model = AirportModel(icao: "JSK", iata: "JFK", name: "Kennedy Airport", municipalityName: "New York", latitude: 45, longitude: 45)
        viewModel = .init(coodinator: coordinator, service: service, model: model)
    }
    
    func testLocation() {
        let noLocationViewModel: AirportDetailsViewModel = .init(coodinator: coordinator, service: service, model: AirportModel(icao: "JSL", iata: "JSK", name: "Kennedy", municipalityName: "NYC", latitude: nil, longitude: nil))
        XCTAssertNil(noLocationViewModel.mapPointRelay.value)
        XCTAssertNotNil(viewModel.mapPointRelay.value)
    }
    
    func testErrorRequest() {
        guard let networkService = service.networkService as? MockNetworkService,
        let coordinator = coordinator else {
            XCTFail()
            return }
        viewModel.selectedOptionRelay.accept(1)
        
        let networkExpectation = XCTestExpectation(description: "Networking")
        let errorHandlerExpectation = XCTestExpectation(description: "Error Handling")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(networkService.didPerformRequest)
            networkExpectation.fulfill()
            XCTAssertTrue(coordinator.didHandleError)
            errorHandlerExpectation.fulfill()
        }
        wait(for: [networkExpectation, errorHandlerExpectation], timeout: 2)
    }
    
    func testActivityIndicator() throws {
        
        var events: [Bool] = []
        let disposeBag = DisposeBag()
        
        viewModel.activityIndicatorRelay
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {
            events.append($0)} )
            .disposed(by: disposeBag)
        
        viewModel.selectedOptionRelay.accept(1)
        
        let networkSearchExpectation = XCTestExpectation(description: "NetworkSearch")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(events, [true, false])
            networkSearchExpectation.fulfill()
        }
        wait(for: [networkSearchExpectation], timeout: 2)
        
    }
    
    func testSuccessfulRequest() {
        guard let url = Bundle.init(for: AirportDetailsTest.self).url(forResource: "airportDetails", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            XCTFail("No Data")
            return  }
        
        guard let networkService = service.networkService as? MockNetworkService,
        let coordinator = coordinator else {
            XCTFail()
            return }
        networkService.sourceJSON = data
        let disposeBag = DisposeBag()
        let dataSourceRelay: BehaviorRelay<[FlightViewViewModelling]> = .init(value: [])
        
        viewModel.dataSourceRelay
            .bind(to: dataSourceRelay)
            .disposed(by: disposeBag)
        
        viewModel.selectedOptionRelay.accept(1)
        
        
        
        let networkExpectation = XCTestExpectation(description: "Networking")
        let errorHandlerExpectation = XCTestExpectation(description: "Error Handling")
        let dataSourceExpectation = XCTestExpectation(description: "Datasource")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(networkService.didPerformRequest)
            networkExpectation.fulfill()
            XCTAssertFalse(coordinator.didHandleError)
            errorHandlerExpectation.fulfill()
            XCTAssertEqual(dataSourceRelay.value.count, 3)
            dataSourceExpectation.fulfill()
        }
        wait(for: [networkExpectation, errorHandlerExpectation], timeout: 2)
    }
    
    func testFlightTransition() throws {
        guard let url = Bundle.init(for: AirportDetailsTest.self).url(forResource: "airportDetails", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            XCTFail("No Data")
            return  }
        
        guard let networkService = service.networkService as? MockNetworkService,
        let coordinator = coordinator, let viewModel = viewModel else {
            XCTFail()
            return }
        networkService.sourceJSON = data
        
        viewModel.selectedOptionRelay.accept(1)
        
        let expectation = XCTestExpectation(description: "Transition")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            viewModel.selectedFlightRelay.accept(0)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertTrue(coordinator.didShowDetails)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3)
    }
    
    func testToMapTransition() throws {
        
        guard let url = Bundle.init(for: AirportDetailsTest.self).url(forResource: "airportDetails", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            XCTFail("No Data")
            return  }
        
        guard let networkService = service.networkService as? MockNetworkService,
        let coordinator = coordinator, let viewModel = viewModel else {
            XCTFail()
            return }
        
        networkService.sourceJSON = data
        
        viewModel.selectedOptionRelay.accept(1)
        let expectation = XCTestExpectation(description: "Map Transition")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            viewModel.selectedFlightRelay.accept(2)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertTrue(coordinator.didSwitchToMap)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3)
    }
    
    func testFavorite() {
        guard let persistanceService = service.persistanceService as? MockPersistanceService else {
            XCTFail()
            return }
        XCTAssertTrue(persistanceService.didCheckForFavorite)
        XCTAssertNotNil(viewModel.isFavoriteRelay.value)
        XCTAssertFalse(viewModel.isFavoriteRelay.value!)
        viewModel.favoriteActionRelay.accept(Void())
        XCTAssertTrue(persistanceService.didAddAirport)
        XCTAssertNotNil(viewModel.isFavoriteRelay.value)
        XCTAssertTrue(viewModel.isFavoriteRelay.value!)
        viewModel.favoriteActionRelay.accept(Void())
        XCTAssertTrue(persistanceService.didRemoveAirport)
        XCTAssertNotNil(viewModel.isFavoriteRelay.value)
        XCTAssertFalse(viewModel.isFavoriteRelay.value!)
    }
    
}
