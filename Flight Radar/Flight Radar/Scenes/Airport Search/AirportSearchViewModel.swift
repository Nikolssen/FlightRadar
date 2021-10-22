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
    @Published var airportInfo: [AirportSearchViewModel] = []
    @Published var shouldShowSpinner: Bool = false
    let buttonAction: PassthroughSubject<Void, Never> = .init()
    let repo: APIRepository = .init()
    var disposeBag: Set<AnyCancellable> = .init()
    init() {
        $searchText
            .removeDuplicates()
            .map { $0.isEmpty ? Constants.searchNearestTitle : Constants.searchTitle }
            .removeDuplicates()
            .assign(to: &$buttonTitle)
        
        buttonAction
//            .throttle(for: 0.5, scheduler: RunLoop.main, latest: false)
//            .flatMapLatest { [repo]  () -> AnyPublisher<DataResponsePublisher<[CompanyModel]>.Output, DataResponsePublisher<[CompanyModel]>.Failure> in
//                repo.genericRequest(request: .company(CompanyGetModel(iataCode: "FR")))
//            }
            .sink { [weak self] in
                
                self?.shouldShowSpinner.toggle()
                
            }
            .store(in: &disposeBag)
        
    }
    
}

private extension AirportSearchViewModel {
    enum Constants {
        static let searchTitle: LocalizedStringKey = "Search"
        static let searchNearestTitle: LocalizedStringKey = "airportsearch_nearest"
        
    }
}
