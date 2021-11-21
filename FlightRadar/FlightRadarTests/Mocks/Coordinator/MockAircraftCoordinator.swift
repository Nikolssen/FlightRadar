//
//  MockAircraftCoordinator.swift
//  FlightRadarTests
//
//  Created by Ivan Budovich on 11/21/21.
//

import Foundation
@testable import FlightRadar
import RxRelay
import RxSwift

final class MockAircraftCoordinator: AircraftCoordinator {
    
    let popRelay: PublishRelay<Void> = .init()
    var didPopController: Bool = false
    private var disposeBag: DisposeBag = .init()
    
    init() {
        popRelay
            .subscribe(onNext: { [weak self] in
                self?.didPopController = true
            })
            .disposed(by: disposeBag)
    }
}
