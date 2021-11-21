//
//  TicketsTest.swift
//  FlightRadarTests
//
//  Created by Ivan Budovich on 11/21/21.
//

import XCTest
@testable import FlightRadar
import RxSwift
import RxRelay

final class TicketsTest: XCTestCase {

    var viewModel: TicketsViewModel!
    var coordinator: MockTicketsCoordinator!
    var service: MockService!
    
    override func setUp() {
        service = .init()
        coordinator = .init()
        viewModel = .init(coordinator: coordinator, service: service)
    }

    func testSearchAvailability() throws {
        var values: [Bool] = []
        let disposeBag = DisposeBag()
        
        viewModel.canSearchRelay
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { values.append($0) })
            .disposed(by: disposeBag)
        
        viewModel.departureRelay.accept("SVO") // false
        viewModel.arrivalRelay.accept("MSQ") // false
        viewModel.dateSelection.accept(Date(timeIntervalSinceNow: 3600*72)) // true
        viewModel.dateSelection.accept(Date(timeIntervalSinceNow: -3600)) // false
        viewModel.dateSelection.accept(Date(timeIntervalSinceNow: 3600*72)) // true
        viewModel.departureRelay.accept("MSQ") // false
        
        XCTAssertEqual(values, [false, false, true, false, true, false])
    }
    
    func testArrivalCall() throws {
        viewModel.arrivalSelectionRelay.accept(Void())
        XCTAssertTrue(coordinator.didShowArrivals)
        XCTAssertFalse(coordinator.didShowDepartures)
    }
    
    func testDepartureCall() throws {
        viewModel.departureSelectionRelay.accept(Void())
        XCTAssertFalse(coordinator.didShowArrivals)
        XCTAssertTrue(coordinator.didShowDepartures)
    }
    
    func testSearchAndSelection() throws {
        guard let url = Bundle.init(for: TicketsTest.self).url(forResource: "tickets", withExtension: "json"),
              let data = try? Data(contentsOf: url), let networkService = service.networkService as? MockNetworkService, let viewModel = viewModel, let coordinator = coordinator else {
                  XCTFail()
            return  }
        
        networkService.sourceJSON = data
        viewModel.departureRelay.accept("SVO")
        viewModel.arrivalRelay.accept("MSQ")
        viewModel.dateSelection.accept(Date(timeIntervalSinceNow: 3600*72))
        
        let expectation = XCTestExpectation(description: "Search")
        viewModel.searchActionRelay.accept(Void())
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(viewModel.dataSourceRelay.value.count, 1)
            viewModel.selectedIndexRelay.accept(0)
            XCTAssertTrue(coordinator.didOpenURL)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.5)
    }

}
