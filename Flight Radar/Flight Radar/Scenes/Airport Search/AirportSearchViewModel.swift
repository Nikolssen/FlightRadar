//
//  AirportSearchViewModel.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/21/21.
//

import Combine
import SwiftUI
import Alamofire

class AirportSearchViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    @Published var buttonTitle: LocalizedStringKey = Constants.searchNearestTitle
    @Published var airportInfo: [AirportDetailsViewModel] = []
    @Published var shouldShowSpinner: Bool = false
    let buttonAction: PassthroughSubject<Void, Never> = .init()
    
    var subscriptions: Set<AnyCancellable> = .init()
    
    let repo: APIRepository = .init()
    let locationManager: LocationManager = .init()
    
    init() {
        
        
        let isTextEmptyPublisher = $searchText
            .removeDuplicates()
            .map { $0.isEmpty }
            .share()
        
        isTextEmptyPublisher
            .map { $0 ? Constants.searchNearestTitle : Constants.searchTitle }
            .removeDuplicates()
            .assign(to: &$buttonTitle)
        
        
        let searchAction = buttonAction
            .throttle(for: 0.5, scheduler: RunLoop.main, latest: false)
            .setFailureType(to: Never.self)
            .withLatestFrom(isTextEmptyPublisher)
            .share()
        
        searchAction
            .filter { !$0 }
            .withLatestFrom($searchText)
        
            .flatMapLatest{ [repo] (query) -> AnyPublisher<DataResponsePublisher<[AirportModel]>.Output, DataResponsePublisher<[AirportModel]>.Failure> in
                repo.genericRequest(request: .airportByFreeText(AirportTextGetModel(q: query)))
            }
            .sink {
                [weak self] in
                switch $0.result {
                case .failure(let error):
                    break
                case .success(let value):
                    //self?.airportInfo = value
                    break
                }
            }
            .store(in: &subscriptions)
        
        let locationSearchAction = searchAction
            .filter { $0 }
            .map { [locationManager] _ in locationManager.currentLocation}
            .share()
        
        locationSearchAction
            .compactMap { $0 }
            .flatMapLatest { [repo] location -> AnyPublisher<DataResponsePublisher<[AirportModel]>.Output, DataResponsePublisher<[AirportModel]>.Failure> in
                repo.genericRequest(request: .airportByLocation(AirportLocationGetModel(lat: location.latitude, lon: location.longitude)))
            }
            .sink {
                [weak self] in
                switch $0.result {
                case .failure(let error):
                    break
                case .success(let value):
                    //self?.airportInfo = value
                    break
                }
            }
            .store(in: &subscriptions)
        
        locationSearchAction
            .filter { $0 == nil }
            .sink { _ in
                
            }
            .store(in: &subscriptions)
        
        
        
    }
    
}

private extension AirportSearchViewModel {
    enum Constants {
        static let searchTitle: LocalizedStringKey = "Search"
        static let searchNearestTitle: LocalizedStringKey = "airportsearch_nearest"
        
    }
}
