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

final class MockAirportSearchCoordinator: AirportSearchCoordinator {
    var didShowDetails: Bool = false
    var didHandleError: Bool = false
    
    private let disposeBag: DisposeBag = .init()
    
    let airportDetailsRelay: PublishRelay<AirportModel> = .init()
    let errorHandlerRelay: PublishRelay<Error> = .init()
    
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
