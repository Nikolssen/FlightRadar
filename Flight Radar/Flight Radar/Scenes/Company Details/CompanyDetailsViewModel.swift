//
//  CompanyDetailsViewModel.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 12/7/21.
//

import Foundation
import Combine
import Alamofire

class CompanyDetailsViewModel: ObservableObject {
    @Published var details: CompanyModel?
    @Published var shouldShowSpinner: Bool = false
    @Published var dismissAction: Bool = false
    let urlAction: PassthroughSubject<Void, Never> = .init()
    let networkService = APIRepository()
    var subscriptions: Set<AnyCancellable> = .init()
    
    init(code: String) {
        Just(code)
            .handleEvents(receiveOutput: { [weak self] _ in self?.shouldShowSpinner = true })
            .receive(on: DispatchQueue.global(qos: .utility))
            .flatMap { [networkService] string -> AnyPublisher<DataResponsePublisher<[CompanyModel]>.Output, Never> in
                networkService.genericRequest(request: .company(.init(iataCode: string)))
            }
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { [weak self] _ in self?.shouldShowSpinner = false })
            .sink { [weak self] in
                switch $0.result {
                case .failure(_):
                    self?.dismissAction = true
                    break
                case .success(let value):
                    if let value = value.first {
                        self?.details = value
                    }
                    else {
                        self?.dismissAction = true
                    }
                }
                
            }
            .store(in: &subscriptions)
    }
    
    
}
