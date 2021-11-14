//
//  MapCoordinator.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/1/21.
//

import UIKit
import RxRelay
import RxSwift

final class MapCoordinator: Coordinator, ErrorHandler {
    
    private let rootViewController: UINavigationController
    private let service: Services
    private weak var modalController: FlightModalController?
    let showModalRelay: PublishRelay<FlightResponseModel.Data> = .init()
    let hideModalRelay: PublishRelay<Void> = .init()
    let errorHandlerRelay: PublishRelay<Error> = .init()
    
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
    }


    
    init(rootViewController: UINavigationController, service: Services) {
        self.rootViewController = rootViewController
        self.service = service
        rootViewController.tabBarItem.selectedImage = .map?.withTintColor(.label).withRenderingMode(.alwaysOriginal)
        rootViewController.tabBarItem.image = .map?.withTintColor(.charcoal).withRenderingMode(.alwaysOriginal)
        rootViewController.setNavigationBarHidden(true, animated: false)
    }
    
    private func showModalController(with data: FlightResponseModel.Data) {
        let controller = FlightModalController(nibName: "FlightModalController", bundle: nil)
        let viewModel = FlightModalViewModel(flightInfo: data)
        controller.viewModel = viewModel
        guard let topController = rootViewController.topViewController, rootViewController.viewControllers.count == 1 else { return }
        topController.addChild(controller)
        controller.view.frame = CGRect(x: 2, y: topController.view.frame.height / 2, width: topController.view.frame.width - 4, height: topController.view.frame.height / 2 - 2)
        topController.view.addSubview(controller.view)
        controller.didMove(toParent: topController)
    }
    
    private func removeModal(controller: UIViewController) {
        controller.willMove(toParent: nil)
        controller.view.removeFromSuperview()
        controller.removeFromParent()
    }
    
}
