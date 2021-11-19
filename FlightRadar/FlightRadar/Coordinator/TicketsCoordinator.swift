//
//  TicketsCoordinator.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/1/21.
//

import UIKit
import RxSwift
import RxRelay

final class TicketsCoordinator: Coordinator, ErrorHandler {
    let viewController: TicketsController
    let service: Services
    var modalController: AirportSelectionController?
    let showArrivalsRelay:PublishRelay<Void> = .init()
    let showDeparturesRelay: PublishRelay<Void> = .init()
    
    let errorHandlerRelay: PublishRelay<Error> = .init()
    let urlRelay: PublishRelay<URL> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    func start() { }
    
    init(service: Services) {
        let controller = TicketsController(nibName: Constants.ticketControllerNibName, bundle: nil)
        controller.tabBarItem.selectedImage = .tickets?.withTintColor(.label).withRenderingMode(.alwaysOriginal)
        controller.tabBarItem.image = .tickets?.withTintColor(.charcoal).withRenderingMode(.alwaysOriginal)
        

        self.viewController = controller
        self.service = service
        
        let viewModel = TicketsViewModel(coordinator: self, service: service)
        controller.viewModel = viewModel
        
        showArrivalsRelay
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let viewModel = self.createAndShowModal()
                viewModel?.selectedAirportRelay
                    .bind(to: self.viewController.viewModel.arrivalRelay)
                    .disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)
        
        showDeparturesRelay
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let viewModel = self.createAndShowModal()
                viewModel?.selectedAirportRelay
                    .bind(to: self.viewController.viewModel.departureRelay)
                    .disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)
        
        errorHandlerRelay
            .subscribe(onNext: { [weak self] _ in
                self?.viewController.alertControllerBinder.onNext((Constants.warning, Constants.errorMessage))
            })
            .disposed(by: disposeBag)
        
        urlRelay
            .subscribe(onNext: { UIApplication.shared.open($0, options: [:], completionHandler: nil)})
            .disposed(by: disposeBag)
        
    }
    
    private func createAndShowModal() -> AirportSelectionViewModelling? {
        guard let mainViewModel = viewController.viewModel else { return nil }
        if let modalController = modalController {
            removeModal(controller: modalController)
        }
        let controller = AirportSelectionController(nibName: Constants.airportSelectionControllerNibName, bundle: nil)
        let viewModel = AirportSelectionViewModel(service: service, viewModel: mainViewModel)
        controller.viewModel = viewModel
        modalController = controller
        viewController.addChild(controller)
        controller.view.frame = CGRect(x: 2, y: viewController.view.frame.height / 2, width: viewController.view.frame.width - 4, height: viewController.view.frame.height / 2 - 2)
        viewController.view.addSubview(controller.view)
        controller.didMove(toParent: viewController)
        
        viewModel.dismissalRelay
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.removeModal(controller: controller)
            })
            .disposed(by: disposeBag)
            
        return viewModel
    }
    
    private func removeModal(controller: UIViewController) {
        controller.willMove(toParent: nil)
        controller.view.removeFromSuperview()
        controller.removeFromParent()
    }
    
    private enum Constants {
        static let ticketControllerNibName: String = "TicketsController"
        static let airportSelectionControllerNibName: String = "AirportSelectionController"
        static let warning: String = "Warning!"
        static let errorMessage: String = "Failed to perform operation"
    }
}
