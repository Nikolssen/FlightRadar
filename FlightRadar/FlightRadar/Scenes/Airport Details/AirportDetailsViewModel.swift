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
    var dataSourceRelay: PublishRelay<Void> { get }
    var airportInfoRelay: PublishRelay<AirportViewViewModelling> { get }
}

protocol AirportDetailsCoordinator {
    var flightOnMapRelay: PublishRelay<FlightResponseModel.Data> { get }
}

final class AirportDetailsViewModel: AirportDetailsViewModelling {
    
    let mapPointRelay: BehaviorRelay<CLLocationCoordinate2D?> = .init(value: nil)
    let dataSourceRelay: PublishRelay<Void> = .init()
    let airportInfoRelay: PublishRelay<AirportViewViewModelling> = .init()
    
    private let arrivalRelay: BehaviorRelay<[FlightResponseModel.Data]> = .init(value: [])
    private let departureRelay: BehaviorRelay<[FlightResponseModel.Data]> = .init(value: [])
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
        
        
        
    }
}
