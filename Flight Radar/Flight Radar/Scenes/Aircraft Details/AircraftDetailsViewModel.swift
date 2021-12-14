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
import UIKit

final class AircraftDetailsViewModel: ObservableObject {
    @Published var model: Aircraft?
    @Published var shouldShowSpinner: Bool = false
    @Published var image: UIImage?
    var dismissAction: CurrentValueSubject<Bool, Never> =  .init(false)
    let onAppearAction: PassthroughSubject<Void, Never> = .init()
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
        let startPublisher =
            onAppearAction
            .withLatestFrom($model)
            .compactMap { [code] in $0 == nil ? code : nil }
            .share()
        
        startPublisher
            .handleEvents(receiveOutput: { [weak self] _ in self?.shouldShowSpinner = true })
            .receive(on: DispatchQueue.global(qos: .utility))
            .flatMap { [networkService] string -> AnyPublisher<DataResponsePublisher<Aircraft>.Output, Never> in
                networkService.genericRequest(request: .aircraft(registration: string))
            }
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { [weak self] _ in self?.shouldShowSpinner = false })
            .sink { [weak self] in
                switch $0.result {
                case .failure(_):
                    self?.dismissAction.send(true)
                    break
                case .success(let value):
                    self?.model = value
                }
                
            }
            .store(in: &subscriptions)
        
        startPublisher
            .receive(on: DispatchQueue.global(qos: .utility))
            .flatMap { [networkService] code -> AnyPublisher<DataResponsePublisher<AircraftImage>.Output, Never> in
                networkService.genericRequest(request: .aircraftImage(registration: code))}
            .sink { [weak self]
                response in
                if let string = response.value?.url, let url = URL(string: string) {
                    self?.imageURL.send(url)
                }
                else {
                    self?.image = UIImage(named: "logo")!
                }
            }
            .store(in: &subscriptions)
        
        imageURL
            .compactMap { $0 }
            .flatMap { Nuke.ImagePipeline.shared.imagePublisher(with: $0) }
            .map { $0.image }
            .sink(receiveCompletion: {_ in }, receiveValue: { [weak self] in self?.image = $0 })
            .store(in: &subscriptions)
    }
}
