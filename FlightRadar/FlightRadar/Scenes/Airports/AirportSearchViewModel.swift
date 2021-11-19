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
    var dataSourceRelay: BehaviorRelay<[AirportViewViewModelling]> { get }
    var activityIndicatorRelay: PublishRelay<Bool> { get }
}

protocol AirportSearchCoordinator: ErrorHandler {
    var airportDetailsRelay: PublishRelay<AirportModel> { get }
}

final class AirportSearchViewModel: AirportSearchViewModelling {
    
    let searchTextRelay: BehaviorRelay<String> = .init(value: "")
    let searchActionRelay: PublishRelay<Void> = .init()
    let selectedCellRelay: PublishRelay<Int> = .init()
    let dataSourceRelay: BehaviorRelay<[AirportViewViewModelling]> = .init(value: [])
    let activityIndicatorRelay: PublishRelay<Bool> = .init()
    
    private let airportModelRelay: BehaviorRelay<[AirportModel]> = .init(value: [])
    private let coordinator: AirportSearchCoordinator
    private let service: Services
    private let disposeBag: DisposeBag = DisposeBag()
    
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
            .do(onError: { [weak self] in
                self?.activityIndicatorRelay.accept(false)
                self?.coordinator.errorHandlerRelay.accept($0)} )
            .retry()
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
            .observe(on: MainScheduler.asyncInstance)
            .do(onError: { [weak self] in
                self?.activityIndicatorRelay.accept(false)
                self?.coordinator.errorHandlerRelay.accept($0)} )
            .retry()
            .do(onNext: { [weak self] _ in self?.activityIndicatorRelay.accept(false) })
            .subscribe(onNext: { [weak self] in
                self?.airportModelRelay.accept($0.items) } )
            .disposed(by: disposeBag)
                
        airportModelRelay
            .observe(on: SerialDispatchQueueScheduler.init(qos: .utility))
            .map { [service] in $0.map { AirportViewViewModel(model: $0, using: service.locationService)}}
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: dataSourceRelay)
            .disposed(by: disposeBag)
        
        locationSearchAction
            .filter { $0 == nil}
            .subscribe(onNext: {[weak self] _ in self?.coordinator.errorHandlerRelay.accept(AirportSearchError.noLocationAvailable)})
            .disposed(by: disposeBag)
        
        airportModelRelay
            .skip(1)
            .filter { $0.isEmpty }
            .subscribe(onNext: {[weak self] _ in self?.coordinator.errorHandlerRelay.accept(AirportSearchError.empty)})
            .disposed(by: disposeBag)
        
        selectedCellRelay
            .withLatestFrom(airportModelRelay) {
                $1[$0]
            }
            .bind(to: coordinator.airportDetailsRelay)
            .disposed(by: disposeBag)
    }
}

enum AirportSearchError: Error {
    case empty
    case noLocationAvailable
}

