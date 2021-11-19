//
//  MockAirportDetailsCoordinator.swift
//  FlightRadarTests
//
//  Created by Ivan Budovich on 11/18/21.
//

import Foundation
import RxSwift
import RxRelay
@testable import FlightRadar

final class MockAirportDetailsCoordinator: AirportDetailsCoordinator {
    
    var didShowDetails: Bool = false
    var didSwitchToMap: Bool = false
    var didHandleError: Bool = false
    
    let flightOnMapRelay: PublishRelay<FlightResponseModel.Data> = .init()
    
    let flightDetailsRelay: PublishRelay<FlightResponseModel.Data> = .init()
    
    let errorHandlerRelay: PublishRelay<Error> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    init() {
        flightOnMapRelay
            .subscribe(onNext: { [weak self] _ in
                self?.didSwitchToMap = true
            })
            .disposed(by: disposeBag)
        
        flightDetailsRelay
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
