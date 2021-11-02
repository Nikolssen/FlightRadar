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
    var activityIndicatorRelay: PublishRelay<Bool> { get }
//    var alertRelay: PublishRelay<Bool> { get }
}

protocol AirportSearchCoordinator {
    var airportDetailsRelay: PublishRelay<AirportModel> { get }
}

class AirportSearchViewModel: AirportSearchViewModelling {
    
    let searchTextRelay: BehaviorRelay<String> = .init(value: "")
    let searchActionRelay: PublishRelay<Void> = .init()
    let selectedCellRelay: PublishRelay<Int> = .init()
    let dataSourceRelay: BehaviorRelay<[AirportCellViewModelling]> = .init(value: [])
    let airportModelRelay: BehaviorRelay<[AirportModel]> = .init(value: [])
    
    let activityIndicatorRelay: PublishRelay<Bool> = .init()
    
    let coordinator: AirportSearchCoordinator
    let service: Services
    
    let disposeBag: DisposeBag = DisposeBag()
    
    init(coordinator: AirportSearchCoordinator, service: Services) {
        self.coordinator = coordinator
        self.service = service
        
        let shouldSearchByLocationObservable =
        searchTextRelay
            .distinctUntilChanged()
            .map { $0.isEmpty }
        
        let searchAction =
        searchActionRelay
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .withLatestFrom(shouldSearchByLocationObservable)
            .share()
        
        searchAction
            .filter { !$0 }
            .withLatestFrom(searchTextRelay)
            .do(onNext: { [weak self] _ in self?.activityIndicatorRelay.accept(true) })
            .observe(on: SerialDispatchQueueScheduler(qos: .utility))
            .flatMapLatest { [service] query -> Observable<AirportResponseModel> in
                service.networkService.request(request: .airportByFreeText(.init(q: query)))
            }
            .observe(on: MainScheduler.asyncInstance)
            .do(onNext: { [weak self] _ in self?.activityIndicatorRelay.accept(false) })
            .subscribe(onNext: { [weak self] in
                self?.airportModelRelay.accept($0.items) } )
            .disposed(by: disposeBag)
        
        let locationSearchAction =
        searchAction
            .filter { $0 }
            .map { [service] _ in service.locationService.currentLocation }
            .share()
        
        locationSearchAction
            .compactMap { $0 }
            .do(onNext: { [weak self] _ in self?.activityIndicatorRelay.accept(true) })
            .observe(on: SerialDispatchQueueScheduler(qos: .utility))
            .flatMapLatest {
                [service] location -> Observable<AirportResponseModel> in
                service.networkService.request(request: .airportByLocation(.init(lat: location.latitude, lon: location.longitude)))
            }
            .do(onError: { error in } )
            .retry()
            .observe(on: MainScheduler.asyncInstance)
            .do(onNext: { [weak self] _ in self?.activityIndicatorRelay.accept(false) })
            .subscribe(onNext: { [weak self] in
                self?.airportModelRelay.accept($0.items) } )
            .disposed(by: disposeBag)
                
        airportModelRelay
            .observe(on: SerialDispatchQueueScheduler.init(qos: .utility))
            .map { [service] in $0.map { AirportCellViewModel(model: $0, using: service.locationService)}}
            .bind(to: dataSourceRelay)
            .disposed(by: disposeBag)
        
        locationSearchAction
            .filter { $0 == nil}
            .debug()
            .subscribe()
            .disposed(by: disposeBag)
    }
}


