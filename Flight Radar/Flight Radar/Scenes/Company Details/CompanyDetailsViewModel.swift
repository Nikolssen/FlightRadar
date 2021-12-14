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
    var dismissAction: CurrentValueSubject<Bool, Never> =  .init(false)
    let onAppearAction: PassthroughSubject<Void, Never> = .init()
    let urlAction: PassthroughSubject<Void, Never> = .init()
    let networkService = APIRepository()
    var subscriptions: Set<AnyCancellable> = .init()
    
    init(code: String) {
        onAppearAction
            .withLatestFrom($details)
            .compactMap { [code] in $0 == nil ? code : nil }
            .handleEvents(receiveOutput: { [weak self] _ in self?.shouldShowSpinner = true })
            .receive(on: DispatchQueue.global(qos: .utility))
            .flatMap { [networkService] string -> AnyPublisher<DataResponsePublisher<[CompanyModel]>.Output, Never> in
                networkService.genericRequest(request: .company(.init(iataCode: string)))
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                switch $0.result {
                case .failure(_):
                    self?.dismissAction.send(true)
                    break
                case .success(let value):
                    if let value = value.first {
                        self?.details = value
                        self?.shouldShowSpinner = false
                    }
                    else {
                        self?.dismissAction.send(true)
                    }
                }
                
            }
            .store(in: &subscriptions)
    }
    
    
}
