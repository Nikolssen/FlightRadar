//
//  MockTicketsCoordinator.swift
//  FlightRadarTests
//
//  Created by Ivan Budovich on 11/21/21.
//

import Foundation
@testable import FlightRadar
import RxSwift
import RxRelay

final class MockTicketsCoordinator: TicketsViewModelCoordinator {
    
    let showArrivalsRelay: PublishRelay<Void> = .init()
    let showDeparturesRelay: PublishRelay<Void> = .init()
    let urlRelay: PublishRelay<URL> = .init()
    let errorHandlerRelay: PublishRelay<Error> = .init()
    
    var didOpenURL: Bool = false
    var didHandleError: Bool = false
    var didShowArrivals: Bool = false
    var didShowDepartures: Bool = false
    
    private let disposeBag: DisposeBag = .init()
    
    init() {
        errorHandlerRelay
            .subscribe(onNext: { [weak self] _ in
                self?.didHandleError = true
            })
            .disposed(by: disposeBag)
        
        urlRelay
            .subscribe(onNext: { [weak self] _ in
                self?.didOpenURL = true
            })
            .disposed(by: disposeBag)
        
        showDeparturesRelay
            .subscribe(onNext: { [weak self] _ in
                self?.didShowDepartures = true
            })
            .disposed(by: disposeBag)
        
        showArrivalsRelay
            .subscribe(onNext: { [weak self] _ in
                self?.didShowArrivals = true
            })
            .disposed(by: disposeBag)
    }
}
