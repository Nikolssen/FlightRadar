//
//  TicketsViewModel.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/11/21.
//

import Foundation
import RxSwift
import RxRelay

protocol TicketsViewModelling: AnyObject {
    var activityIndicatorRelay: PublishRelay<Bool> { get }
    var arrivalSelectionRelay: PublishRelay<Void> { get }
    var departureSelectionRelay: PublishRelay<Void> { get }
    var dateSelectionRelay: BehaviorRelay<Date?> { get }
    var dataSourceRelay: PublishRelay<[TicketCellViewModelling]> { get }
    var arrivalRelay: BehaviorRelay<String?> { get }
    var departureRelay: BehaviorRelay<String?> { get }
}



final class TicketsViewModel: TicketsViewModelling {
    let dataSourceRelay: PublishRelay<[TicketCellViewModelling]> = .init()
    let activityIndicatorRelay: PublishRelay<Bool> = .init()
    let arrivalSelectionRelay: PublishRelay<Void> = .init()
    let departureSelectionRelay: PublishRelay<Void> = .init()
    let dateSelectionRelay: BehaviorRelay<Date?> = .init(value: nil)
    
    let arrivalRelay: BehaviorRelay<String?> = .init(value: nil)
    let departureRelay: BehaviorRelay<String?> = .init(value: nil)
    
    
    private let service: Services
    private let coordinator: TicketsCoordinator
    private let disposeBag: DisposeBag = .init()
    
    init(coordinator: TicketsCoordinator, service: Services) {
        self.coordinator = coordinator
        self.service = service
        
        departureSelectionRelay
            .bind(to: coordinator.showDeparturesRelay)
            .disposed(by: disposeBag)
        
        arrivalSelectionRelay
            .bind(to: coordinator.showArrivalsRelay)
            .disposed(by: disposeBag)
    }
}
