//
//  CompanyViewModel.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/8/21.
//

import Foundation
import RxRelay
import RxSwift
import UIKit

protocol CompanyViewModelling {
    var isLowcostCarrier: Bool { get }
    var hasLink: Bool { get }
    var iataCode: String? { get }
    var icaoCode: String? { get }
    var name: String? { get }
    var openLinkRelay: PublishRelay<Void> { get }
    var activityIndicatorRelay: PublishRelay<Bool> { get }
    var startRelay: PublishRelay<Bool> { get }
    var updateRelay: PublishRelay<Void> { get }
}

protocol CompanyCoordinator: ErrorHandler {
    var popRelay: PublishRelay<Void> { get }
}

final class CompanyViewModel: CompanyViewModelling {
    var name: String? {
        dataRelay.value?.name
    }

    var isLowcostCarrier: Bool {
        dataRelay.value?.isLowCostCarrier ?? false
    }

    var hasLink: Bool {
        dataRelay.value?.website != nil
    }

    var iataCode: String? {
        dataRelay.value?.iata
    }

    var icaoCode: String? {
        dataRelay.value?.icao
    }
    
    private let coordinator: CompanyCoordinator
    private let service: Services
    private let disposeBag: DisposeBag = .init()
    
    private let dataRelay: BehaviorRelay<CompanyModel?> = .init(value: nil)
    let activityIndicatorRelay: PublishRelay<Bool> = .init()
    let startRelay: PublishRelay<Bool> = .init()
    let updateRelay: PublishRelay<Void> = .init()
    var openLinkRelay: PublishRelay<Void> = .init()
    
    init(coordinator: CompanyCoordinator, service: Services, iataCode: String) {
        self.coordinator = coordinator
        self.service = service
        
        startRelay
            .do(onNext: { [weak self] _ in self?.activityIndicatorRelay.accept(true) })
            .observe(on: SerialDispatchQueueScheduler.init(qos: .utility))
            .flatMap{ [service] _ -> Observable<[CompanyModel]> in service.networkService.request(request: .company(.init(iataCode: iataCode))) }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {[weak self] in
                guard let self = self else { return }
                guard let company = $0.first else {
                    self.coordinator.popRelay.accept(Void())
                    return
                }
                self.activityIndicatorRelay.accept(false)
                self.dataRelay.accept(company)
                self.updateRelay.accept(Void())
            }, onError: {[weak self] _ in
                guard let self = self else { return }
                self.coordinator.popRelay.accept(Void())})
            .disposed(by: disposeBag)
        
        openLinkRelay
            .withLatestFrom(dataRelay)
            .compactMap{ $0?.website }
            .compactMap{ URL(string: $0) }
            .subscribe(onNext: { UIApplication.shared.open($0, options: [:], completionHandler: nil)})
            .disposed(by: disposeBag)
    }
    
}
