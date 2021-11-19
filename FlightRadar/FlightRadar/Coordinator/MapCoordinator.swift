//
//  MapCoordinator.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/1/21.
//

import UIKit
import RxRelay
import RxSwift

final class MapCoordinator: Coordinator, FlightCoordinator, CompanyCoordinator, AircraftCoordinator, FlightModalCoordinator, ErrorHandler {
    
    
    private let rootViewController: UINavigationController
    private let service: Services
    private weak var modalController: FlightModalController?
    let showModalRelay: PublishRelay<FlightResponseModel.Data> = .init()
    let hideModalRelay: PublishRelay<Void> = .init()
    let errorHandlerRelay: PublishRelay<Error> = .init()
    let flightDetailsRelay: PublishRelay<FlightResponseModel.Data> = .init()
    let companySelectionRelay: PublishRelay<String> = .init()
    let aircraftSelectionRelay: PublishRelay<String> = .init()
    let popRelay: PublishRelay<Void> = .init()
    let urlRelay: PublishRelay<URL> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    func start() {
        let controller = MapController()
        let viewModel = MapViewModel()
        controller.viewModel = viewModel
        
        rootViewController.setViewControllers([controller], animated: false)
        
        showModalRelay
            .do(onNext: { [weak self] _ in
                guard let controller = self?.modalController else { return }
                self?.removeModal(controller: controller)
            })
            .bind(onNext: showModalController(with:))
                .disposed(by: disposeBag)
                
        hideModalRelay
            .subscribe(onNext: { [weak self] _ in
                guard let controller = self?.modalController else { return }
                self?.removeModal(controller: controller) })
            .disposed(by: disposeBag)
                
        companySelectionRelay
            .subscribe(onNext: {[weak self] in
                guard let self = self else { return }
                self.rootViewController.pushViewController(self.companyDetailsController(code: $0), animated: true)
            })
            .disposed(by: disposeBag)
                
        aircraftSelectionRelay
            .subscribe(onNext: {[weak self] in
                guard let self = self else { return }
                self.rootViewController.pushViewController(self.aircraftDetailsController(code: $0), animated: true)
            })
            .disposed(by: disposeBag)
                
        popRelay
            .subscribe(onNext: {[weak self] in self?.rootViewController.popViewController(animated: true)})
            .disposed(by: disposeBag)
                
        errorHandlerRelay
            .subscribe(onNext: { [weak self] _ in
                self?.rootViewController.topViewController?
                .alertControllerBinder.onNext((Constants.warning, Constants.errorMessage))
                })
            .disposed(by: disposeBag)
                
        showModalRelay
                .compactMap { $0.live }
                .subscribe(onNext: {[weak self] in
                    (self?.rootViewController.viewControllers[0] as? MapController)?.viewModel.flightRelay.accept($0)
                })
                .disposed(by: disposeBag)
        
        urlRelay
            .subscribe(onNext: { UIApplication.shared.open($0, options: [:], completionHandler: nil)})
            .disposed(by: disposeBag)
    }
    
    
    
    
    init(rootViewController: UINavigationController, service: Services) {
        self.rootViewController = rootViewController
        self.service = service
        rootViewController.tabBarItem.selectedImage = .map?.withTintColor(.label).withRenderingMode(.alwaysOriginal)
        rootViewController.tabBarItem.image = .map?.withTintColor(.charcoal).withRenderingMode(.alwaysOriginal)
        rootViewController.setNavigationBarHidden(true, animated: false)
    }
    
    private func showModalController(with data: FlightResponseModel.Data) {
        let controller = FlightModalController(nibName: Constants.modalControllerNibName, bundle: nil)
        let viewModel = FlightModalViewModel(coordinator: self, flightInfo: data)
        controller.viewModel = viewModel
        guard let topController = rootViewController.topViewController, rootViewController.viewControllers.count == 1 else { return }
        topController.addChild(controller)
        controller.view.frame = CGRect(x: 2, y: topController.view.frame.height / 2, width: topController.view.frame.width - 4, height: topController.view.frame.height / 2 - 2)
        topController.view.addSubview(controller.view)
        self.modalController = controller
        controller.didMove(toParent: topController)
    }
    private func flightDetailsController(model: FlightResponseModel.Data) -> FlightController {
        let controller = FlightController(nibName: Constants.flightControllerNibName, bundle: nil)
        let viewModel = FlightViewModel(coordinator: self, flightInfo: model)
        controller.viewModel = viewModel
        return controller
    }
    
    private func companyDetailsController(code: String) -> CompanyController {
        let controller = CompanyController(nibName: Constants.companyControllerNibName, bundle: nil)
        let viewModel = CompanyViewModel(coordinator: self, service: service, iataCode: code)
        controller.viewModel = viewModel
        return controller
    }
    
    private func aircraftDetailsController(code: String) -> AircraftController {
        let controller = AircraftController(nibName: Constants.aircraftControllerNibName, bundle: nil)
        let viewModel = AircraftViewModel(coordinator: self, service: service, icao24: code)
        controller.viewModel = viewModel
        return controller
    }
    
    private func removeModal(controller: UIViewController) {
        controller.willMove(toParent: nil)
        controller.view.removeFromSuperview()
        controller.removeFromParent()
    }
    
    private enum Constants {
        static let modalControllerNibName: String = "FlightModalController"
        static let flightControllerNibName: String = "FlightController"
        static let companyControllerNibName: String = "CompanyController"
        static let aircraftControllerNibName: String = "AircraftController"
        static let warning: String = "Warning!"
        static let errorMessage: String = "Failed to perform operation"
    }
}
