//
//  AirportSearchViewModel.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/28/21.
//

import Foundation
import RxSwift
import RxRelay

protocol AirportSearchViewModelling {
    var searchTextRelay: BehaviorRelay<String> { get }
    var searchActionRelay: PublishRelay<Void> { get }
    var selectedCellRelay: PublishRelay<Int> { get }
    var dataSourceRelay: BehaviorRelay<[AirportCellViewModelling]> { get }
}

protocol AirportSearchCoordinator {
    var airportDetailsRelay: PublishRelay<AirportResponseModel> { get }
}

struct AirportSearchViewModel: AirportSearchViewModelling {
    
    let searchTextRelay: BehaviorRelay<String> = .init(value: "")
    let searchActionRelay: PublishRelay<Void> = .init()
    let selectedCellRelay: PublishRelay<Int> = .init()
    let dataSourceRelay: BehaviorRelay<[AirportCellViewModelling]> = .init(value: [])
    let airportModelRelay: BehaviorRelay<[AirportResponseModel]> = .init(value: [])
    
    let coordinator: AirportSearchCoordinator
    let service: Services
    
    let disposeBag: DisposeBag = DisposeBag()
    
    init(coordinator: AirportSearchCoordinator, service: Services) {
        self.coordinator = coordinator
        self.service = service
    }
}
