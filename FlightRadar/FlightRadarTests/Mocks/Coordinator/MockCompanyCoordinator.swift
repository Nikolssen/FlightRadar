//
//  MockCompanyCoordinator.swift
//  FlightRadarTests
//
//  Created by Ivan Budovich on 11/19/21.
//

import Foundation
@testable import FlightRadar
import RxSwift
import RxRelay

final class MockCompanyCoordinator: CompanyCoordinator, AircraftCoordinator {
    
    var didPopController: Bool = false
    var didOpenURL: Bool = false
    let popRelay: PublishRelay<Void> = .init()
    let urlRelay: PublishRelay<URL> = .init()
    private let disposeBag: DisposeBag = .init()
    
    init() {
        popRelay
            .subscribe(onNext: { [weak self] in
                self?.didPopController = true
            })
            .disposed(by: disposeBag)
        urlRelay
            .subscribe(onNext: { [weak self] _ in
                self?.didOpenURL = true
            })
            .disposed(by: disposeBag)
    }
}
