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
}



final class TicketsViewModel: TicketsViewModelling {
    var airportSelectionViewModel: AirportSelectionViewModel?
    let dataSourceRelay: PublishRelay<[TicketCellViewModelling]> = .init()
    let activityIndicatorRelay: PublishRelay<Bool> = .init()
    let arrivalSelectionRelay: PublishRelay<Void> = .init()
    let departureSelectionRelay: PublishRelay<Void> = .init()
    let dateSelectionRelay: BehaviorRelay<Date?> = .init(value: nil)
    
    private let service: Services
    private let coordinator: TicketsCoordinator
    private let disposeBag: DisposeBag = .init()
    
    init(coordinator: TicketsCoordinator, service: Services) {
        self.coordinator = coordinator
        self.service = service
        
        
    }
}
