//
//  AirportDetailsViewModel.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/2/21.
//

import Foundation
import CoreLocation
import RxSwift
import RxRelay

protocol AirportDetailsViewModelling {
    var mapPointRelay: BehaviorRelay<CLLocationCoordinate2D?> { get }
    var dataSourceRelay: PublishRelay<[FlightViewViewModelling]> { get }
    var airportInfoRelay: PublishRelay<AirportViewViewModelling> { get }
    var selectedOptionRelay: BehaviorRelay<Int> { get }
    var selectedFlightRelay: PublishRelay<Int> { get }
}

protocol AirportDetailsCoordinator {
    var flightOnMapRelay: PublishRelay<FlightResponseModel.Data> { get }
}

final class AirportDetailsViewModel: AirportDetailsViewModelling {
    
    let mapPointRelay: BehaviorRelay<CLLocationCoordinate2D?> = .init(value: nil)
    let dataSourceRelay: PublishRelay<[FlightViewViewModelling]> = .init()
    let airportInfoRelay: PublishRelay<AirportViewViewModelling> = .init()
    let selectedOptionRelay: BehaviorRelay<Int> = .init(value: 0)
    let selectedFlightRelay: PublishRelay<Int> = .init()
    
    private let arrivalRelay: BehaviorRelay<[FlightResponseModel.Data]?> = .init(value: nil)
    private let departureRelay: BehaviorRelay<[FlightResponseModel.Data]?> = .init(value: nil)
    private let modelRelay: BehaviorRelay<AirportModel>
    private let coordinator: AirportDetailsCoordinator
    private let service: Services
    private let disposeBag: DisposeBag = .init()
    
    init(coodinator: AirportDetailsCoordinator, service: Services, model: AirportModel) {
        self.coordinator = coodinator
        self.service = service
        self.modelRelay = .init(value: model)
        
        modelRelay
            .observe(on: SerialDispatchQueueScheduler.init(qos: .utility))
            .map { [service] in AirportViewViewModel(model: $0, using: service.locationService)}
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: airportInfoRelay)
            .disposed(by: disposeBag)
        
        modelRelay
            .compactMap { $0.location }
            .map { CLLocationCoordinate2D(latitude: $0.lat, longitude: $0.lon) }
            .bind(to: mapPointRelay)
            .disposed(by: disposeBag)
        
        let selectedIndexObservable =
        selectedOptionRelay
            .withLatestFrom(mapPointRelay) { (index, coordinates) -> (Int) in
                if coordinates == nil { return index + 1}
                if index == 0 && coordinates != nil { return 0 }
                return index
            }
            .share()
        
        Observable.combineLatest(selectedIndexObservable, departureRelay)
            .filter { $0.0 == 1}
            .compactMap { $1 }
            .map { $0.map { FlightViewViewModel(departureCode: $0.departure?.iata, arrivalCode: $0.arrival?.iata, time: DateFormatter.substract($0.departure?.time, d2: $0.arrival?.time)) }}
            .bind(to: dataSourceRelay)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(selectedIndexObservable, arrivalRelay)
            .filter { $0.0 == 2}
            .compactMap { $1 }
            .map { $0.map { FlightViewViewModel(departureCode: $0.departure?.iata, arrivalCode: $0.arrival?.iata, time: DateFormatter.substract($0.departure?.time, d2: $0.arrival?.time)) }}
            .bind(to: dataSourceRelay)
            .disposed(by: disposeBag)
        
        selectedIndexObservable
            .withLatestFrom(departureRelay){ ($0, $1) }
            .filter { $0 == 1 && $1 == nil}
            .withLatestFrom(modelRelay)
            .compactMap { $0.iata }
            .observe(on: SerialDispatchQueueScheduler.init(qos: .utility))
            .flatMapLatest { [service] code -> Observable<FlightResponseModel> in
                service.networkService.request(request: APIRequest.allFlights(.init(departureCode: code)))
            }
            .do(onError: { _ in })
            .retry()
            .map { $0.data }
            .bind(to: departureRelay)
            .disposed(by: disposeBag)
        
        selectedIndexObservable
            .withLatestFrom(arrivalRelay) { ($0, $1) }
            .filter { $0 == 2 && $1 == nil}
            .withLatestFrom(modelRelay)
            .compactMap { $0.iata }
            .observe(on: SerialDispatchQueueScheduler.init(qos: .utility))
            .flatMapLatest { [service] code -> Observable<FlightResponseModel> in
                service.networkService.request(request: APIRequest.allFlights(.init(arrivalCode: code)))
            }
            .do(onError: { _ in })
            .retry()
            .map { $0.data }
            .bind(to: arrivalRelay)
            .disposed(by: disposeBag)
        
        let selectedFlightObservable =
        selectedFlightRelay
            .withLatestFrom(selectedIndexObservable) { ($0, $1)}
            .share()
        
        selectedFlightObservable
            .filter { $1 == 1}
            .map { $0.0 }
            .withLatestFrom(departureRelay) { (index, values) -> FlightResponseModel.Data? in
                guard let values = values, values.count > index else { return nil }
                return values[index]
            }
            .compactMap { $0 }
            .bind(to: coodinator.flightOnMapRelay)
            .disposed(by: disposeBag)
        
        selectedFlightObservable
            .filter { $1 == 2}
            .map { $0.0 }
            .withLatestFrom(arrivalRelay) { (index, values) -> FlightResponseModel.Data? in
                guard let values = values, values.count > index else { return nil }
                return values[index]
            }
            .compactMap { $0 }
            .bind(to: coodinator.flightOnMapRelay)
            .disposed(by: disposeBag)
    }
    
}
