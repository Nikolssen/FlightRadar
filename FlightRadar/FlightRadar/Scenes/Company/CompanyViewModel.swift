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
    var isLowcostCarrier: Bool? { get }
    var hasLink: Bool? { get }
    var iataCode: String? { get }
    var icaoCode: String? { get }
    var name: String? { get }
    var openLinkRelay: PublishRelay<Void> { get }
}

class CompanyViewModel: CompanyViewModelling {
    var name: String? {
        dataRelay.value?.name
    }

    var isLowcostCarrier: Bool? {
        dataRelay.value?.isLowCostCarrier
    }

    var hasLink: Bool? {
        dataRelay.value?.website != nil
    }

    var iataCode: String? {
        dataRelay.value?.iata
    }

    var icaoCode: String? {
        dataRelay.value?.icao
    }

    var openLinkRelay: PublishRelay<Void> = .init()
    let disposeBag: DisposeBag = .init()
    private let dataRelay: BehaviorRelay<CompanyModel?> = .init(value: nil)
    
    init(service: Services, iataCode: String) {
        service.networkService.request(request: .company(.init(iataCode: iataCode)))
            .subscribe(onNext: {[weak self] in self?.dataRelay.accept($0)}, onError: {error in })
            .disposed(by: disposeBag)
        
        openLinkRelay
            .withLatestFrom(dataRelay)
            .compactMap{ $0?.website }
            .compactMap{ URL(string: $0) }
            .subscribe(onNext: { UIApplication.shared.open($0, options: [:], completionHandler: nil)})
            .disposed(by: disposeBag)
    }
    
    //UIApplication.shared.open(url)
}
