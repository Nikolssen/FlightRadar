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
    @Published var airportViewModels: [AirportViewViewModel] = .init()
    @Published var shouldShowSpinner: Bool = false
    @Published var alertViewModel: AlertViewModel?
    
    private var airports: [AirportModel] = .init()
    
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
            .handleEvents(receiveOutput: {[weak self] _ in self?.shouldShowSpinner = true })
            .receive(on: DispatchQueue.global(qos: .utility))
            .flatMapLatest{ [repo] (query) -> AnyPublisher<DataResponsePublisher<[AirportModel]>.Output, DataResponsePublisher<[AirportModel]>.Failure> in
                repo.genericRequest(request: .airportByFreeText(AirportTextGetModel(q: query)))
            }
            .receive(on: DispatchQueue.main)
            .sink {
                [weak self] in
                self?.process(result: $0.result)
            }
            .store(in: &subscriptions)
        
        let locationSearchAction = searchAction
            .filter { $0 }
            .map { [locationManager] _ in locationManager.currentLocation}
            .share()
        
        locationSearchAction
            .compactMap { $0 }
            .receive(on: DispatchQueue.global(qos: .utility))
            .flatMapLatest { [repo] location -> AnyPublisher<DataResponsePublisher<[AirportModel]>.Output, DataResponsePublisher<[AirportModel]>.Failure> in
                repo.genericRequest(request: .airportByLocation(AirportLocationGetModel(lat: location.latitude, lon: location.longitude)))
            }
            .receive(on: DispatchQueue.main)
            .sink {
                [weak self] in
                self?.process(result: $0.result)
            }
            .store(in: &subscriptions)
        
        locationSearchAction
            .filter { $0 == nil }
            .sink { _ in
                
            }
            .store(in: &subscriptions)
        
    }
    
    
    func process(result: Result<[AirportModel], AFError>){
        switch result {
        case .failure(let error):
            alertViewModel = AlertViewModel(id: 0, title: "Error", description: error.localizedDescription)
            break
        case .success(let values):
            self.airports = values
            var airportViewModels = Array<AirportViewViewModel>()
            for (index, value) in values.enumerated() {
                airportViewModels.append(AirportViewViewModel(model: value, using: locationManager, index: index))
            }
            self.airportViewModels = airportViewModels
            if airportViewModels.isEmpty {
                alertViewModel = AlertViewModel(id: 1, title: "No data", description: "Failed to provide information that satisfies your request.")
            }
        }
        shouldShowSpinner = false
    }
    
}

private extension AirportSearchViewModel {
    enum Constants {
        static let searchTitle: LocalizedStringKey = "Search"
        static let searchNearestTitle: LocalizedStringKey = "airportsearch_nearest"
        
    }
}
