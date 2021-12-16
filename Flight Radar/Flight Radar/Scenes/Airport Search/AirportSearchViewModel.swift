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
    @Published var selectedIndex: Int?
    @Published var navigation: Bool = false
    var airports: [AirportModel] = .init()
    
    let buttonAction: PassthroughSubject<Void, Never> = .init()
    
    var subscriptions: Set<AnyCancellable> = .init()
    
    
    let service: Service
    
    init(service: Service) {
        self.service = service
        
        let isTextEmptyPublisher = $searchText
            .removeDuplicates()
            .map { $0.isEmpty }
            .share(replay: 1)
        
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
            .flatMapLatest{ [service] (query) -> AnyPublisher<DataResponsePublisher<AirportResponseModel>.Output, Never> in
                service.networkService.genericRequest(request: .airportByFreeText(AirportTextGetModel(q: query)))
            }
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: {[weak self] _ in self?.shouldShowSpinner = false })
            .sink {
                [weak self] in
                self?.process(result: $0.result)
            }
            .store(in: &subscriptions)

        let locationSearchAction = searchAction
            .filter { $0 }
            .map { [service] _ in service.locationService.currentLocation}
            .share()

        locationSearchAction
            .compactMap { $0 }
            .handleEvents(receiveOutput: {[weak self] _ in self?.shouldShowSpinner = true })
            .receive(on: DispatchQueue.global(qos: .utility))
            .flatMapLatest { [service] location -> AnyPublisher<DataResponsePublisher<AirportResponseModel>.Output, Never> in
                service.networkService.genericRequest(request: .airportByLocation(AirportLocationGetModel(lat: location.latitude, lon: location.longitude)))
            }
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: {[weak self] _ in self?.shouldShowSpinner = false })
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
        $selectedIndex
            .sink(receiveValue: {_ in })
            .store(in: &subscriptions)
    }
    
    
    func process(result: Result<AirportResponseModel, AFError>){
        switch result {
        case .failure(let error):
            print(error)
            break
        case .success(let values):
            self.airports = values.items
            var airportViewModels = Array<AirportViewViewModel>()
            for (index, value) in values.items.enumerated() {
                airportViewModels.append(AirportViewViewModel(model: value, using: service.locationService, index: index))
            }
            self.airportViewModels = airportViewModels
            if airportViewModels.isEmpty {

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
