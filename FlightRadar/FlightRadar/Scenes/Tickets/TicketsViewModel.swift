//
//  TicketsViewModel.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/11/21.
//

import Foundation
import RxSwift
import RxRelay
import UIKit

protocol TicketsViewModelling: AnyObject {
    var activityIndicatorRelay: PublishRelay<Bool> { get }
    var arrivalSelectionRelay: PublishRelay<Void> { get }
    var departureSelectionRelay: PublishRelay<Void> { get }
    var dateSelectionRelay: BehaviorRelay<Date?> { get }
    var dataSourceRelay: PublishRelay<[TicketCellViewModelling]> { get }
    var arrivalRelay: BehaviorRelay<String?> { get }
    var departureRelay: BehaviorRelay<String?> { get }
    var searchActionRelay: PublishRelay<Void> { get }
    var canSearchRelay: PublishRelay<Bool> { get }
    var selectedIndexRelay: PublishRelay<Int> { get }
}



final class TicketsViewModel: TicketsViewModelling {
    let dataSourceRelay: PublishRelay<[TicketCellViewModelling]> = .init()
    let activityIndicatorRelay: PublishRelay<Bool> = .init()
    let arrivalSelectionRelay: PublishRelay<Void> = .init()
    let departureSelectionRelay: PublishRelay<Void> = .init()
    let dateSelectionRelay: BehaviorRelay<Date?> = .init(value: nil)
    let arrivalRelay: BehaviorRelay<String?> = .init(value: nil)
    let departureRelay: BehaviorRelay<String?> = .init(value: nil)
    let searchActionRelay: PublishRelay<Void> = .init()
    let canSearchRelay: PublishRelay<Bool> = .init()
    let selectedIndexRelay: PublishRelay<Int> = .init()
    private let responseRelay: BehaviorRelay<[TicketModel]> = .init(value: [])
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
        
        Observable.combineLatest(arrivalRelay, departureRelay, dateSelectionRelay)
            
            .map {
                (arrival, departure, date) in
                guard let arrival = arrival, let departure = departure, let date = date else { return false }
                return arrival != departure && date > Date() }
            .bind(to: canSearchRelay)
            .disposed(by: disposeBag)
       
        searchActionRelay
            .do(onNext: {[weak self] in self?.activityIndicatorRelay.accept(true)})
            .observe(on: SerialDispatchQueueScheduler(qos: .utility))
            .withLatestFrom(Observable.combineLatest(arrivalRelay, departureRelay, dateSelectionRelay))
            .filter { $0 != nil && $1 != nil && $2 != nil}
            .flatMapLatest { [service] (arrival, departure, date) -> Observable<TicketResponseModel> in
                service.networkService.request(request: .tickets(.init(arrival: arrival!, departure: departure!, date: DateFormatter.encodeDate(date: date!))))
            }
            .observe(on: MainScheduler.instance)
            .do(onNext: {[weak self] _ in self?.activityIndicatorRelay.accept(false)}, onError: {[weak self] error in self?.activityIndicatorRelay.accept(false)
                coordinator.errorHandlerRelay.accept(error)
            })
            .retry()
            .map { $0.flights}
            .subscribe(onNext: {[weak self] in self?.responseRelay.accept($0)})
            .disposed(by: disposeBag)
        
        responseRelay
            .map { $0.map { TicketCellViewModel(date: $0.departureDate, company: $0.airlines, price: "\($0.price) USD")} }
            .bind(to: dataSourceRelay)
            .disposed(by: disposeBag)
        
        selectedIndexRelay
            .withLatestFrom(responseRelay) { $1[$0].url }
            .compactMap{ URL(string: $0) }
            .bind(to: coordinator.urlRelay)
            .disposed(by: disposeBag)
        
    }
}
