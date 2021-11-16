//
//  MockAirportSearchCoordinator.swift
//  FlightRadarTests
//
//  Created by Ivan Budovich on 11/16/21.
//

import Foundation
@testable import FlightRadar
import RxRelay
import RxSwift

class MockAirportSearchCoordinator: AirportSearchCoordinator {
    var didShowDetails: Bool = false
    var didHandleError: Bool = false
    
    private let disposeBag: DisposeBag = .init()
    
    var airportDetailsRelay: PublishRelay<AirportModel> = .init()
    var errorHandlerRelay: PublishRelay<Error> = .init()
    
    init() {
        airportDetailsRelay
            .subscribe(onNext: { [weak self] _ in
                self?.didShowDetails = true
            })
            .disposed(by: disposeBag)
        
        errorHandlerRelay
            .subscribe(onNext: { [weak self] _ in
                self?.didHandleError = true
            })
            .disposed(by: disposeBag)
    }

}
