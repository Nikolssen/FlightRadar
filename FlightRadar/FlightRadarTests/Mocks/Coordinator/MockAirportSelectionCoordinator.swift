//
//  MockAirportSelectionCoordinator.swift
//  FlightRadarTests
//
//  Created by Ivan Budovich on 11/21/21.
//

import Foundation
import RxSwift
import RxRelay
@testable import FlightRadar

final class MockAirportSelectionCoordinator: AirportSelectionCoordinator {
    
    var didSelectAirport: Bool = false
    var didDismissModal: Bool = false
    var didHandleError: Bool = false
    let airportRelay: BehaviorRelay<String?> = .init(value: nil)
    
    let selectedAirportRelay: PublishRelay<String?> = .init()
    
    let dismissalRelay: PublishRelay<Void> = .init()
    
    let errorHandlerRelay: PublishRelay<Error> = .init()
    private let disposeBag: DisposeBag = .init()
    init() {
        errorHandlerRelay
            .subscribe(onNext: { [weak self] _ in
                self?.didHandleError = true
            })
            .disposed(by: disposeBag)
        
        selectedAirportRelay
            .compactMap { $0 }
            .subscribe(onNext: { [weak self] in
                self?.airportRelay.accept($0)
                self?.didSelectAirport = true
                
            })
            .disposed(by: disposeBag)
        
        dismissalRelay
            .subscribe(onNext: { [weak self] in
                self?.didDismissModal = true
            })
            .disposed(by: disposeBag)
    }
    
}
