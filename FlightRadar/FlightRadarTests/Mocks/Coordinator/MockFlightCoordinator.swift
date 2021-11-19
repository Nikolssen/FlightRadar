//
//  MockFlightCoordinator.swift
//  FlightRadarTests
//
//  Created by Ivan Budovich on 11/19/21.
//

import Foundation
@testable import FlightRadar
import RxSwift
import RxRelay

final class MockFlightCoordinator: FlightCoordinator {
    
    let companySelectionRelay: PublishRelay<String> = .init()
    
    let aircraftSelectionRelay: PublishRelay<String> = .init()
    
    var didShowCompany: Bool = false
    var didShowAircraft: Bool = false
    
    private let disposeBag: DisposeBag = .init()
    
    init() {
        companySelectionRelay
            .subscribe(onNext: { [weak self] _ in
                self?.didShowCompany = true
            })
            .disposed(by: disposeBag)
        
        aircraftSelectionRelay
            .subscribe(onNext: { [weak self] _ in
                self?.didShowAircraft = true
            })
            .disposed(by: disposeBag)
    }
    
}
