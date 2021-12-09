//
//  AircraftDetailsViewModel.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 12/7/21.
//

import Foundation
import Combine
import Alamofire
import Nuke

final class AircraftDetailsViewModel: ObservableObject {
    @Published var model: Aircraft?
    @Published var shouldShowSpinner: Bool = false
    @Published var dismissAction: Bool = false
    private let imageURL: CurrentValueSubject<URL?, Never> = .init(nil)
    
    var subscriptions: Set<AnyCancellable> = .init()
    let networkService = APIRepository()
    
    var title: String? {
            model?.productionLine
        }
        
        var registrationNumber: String? {
            model?.registration
        }
        
        var owner: String? {
            model?.owner
        }
        
        var numberOfEngines: String? {
            guard let number = model?.numberOfEngines else { return nil }
            return "\(number)"
        }
        
        var age: String? {
            guard let age = model?.age else { return nil }
            return NumberFormatter.round(number: age)
        }
        
        var firstFlightDate: String? {
            DateFormatter.date(from: model?.firstFlight)
        }
    
    init(code: String) {
        Just(code)
            .handleEvents(receiveOutput: { [weak self] _ in self?.shouldShowSpinner = true })
            .receive(on: DispatchQueue.global(qos: .utility))
            .flatMap { [networkService] string -> AnyPublisher<DataResponsePublisher<Aircraft>.Output, Never> in
                networkService.genericRequest(request: .aircraft(registration: string))
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                switch $0.result {
                case .failure(_):
                    self?.dismissAction = true
                    break
                case .success(let value):
                    self?.model = value
                }
                
            }
            .store(in: &subscriptions)
        
        Just(code)
            .receive(on: DispatchQueue.global(qos: .utility))
            .flatMap { [networkService] code -> AnyPublisher<DataResponsePublisher<AircraftImage>.Output, Never> in
                networkService.genericRequest(request: .aircraftImage(registration: code))}
            .sink { [weak self]
                response in
                if let string = response.value?.url, let url = URL(string: string) {
                    self?.imageURL.send(url)
                }
            }
            .store(in: &subscriptions)
        
        imageURL
            .compactMap { $0 }
            .flatMap { Nuke.ImagePipeline.shared.imagePublisher(with: $0) }
            .map { $0.image }
            .sink(receiveCompletion: {_ in }, receiveValue: { _ in })
            .store(in: &subscriptions)
    }
}
