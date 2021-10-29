//
//  Rx + ActivityIndicator.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/29/21.
//

import UIKit
import RxCocoa
import RxSwift

extension UIViewController {
    var activityIndicatorBinding: Binder<Bool>{
        return Binder(self, binding: { [weak self] (viewController, isRefreshing) in
            if isRefreshing
            {
                self?.showActivityIndicator()
            }
            else
            {
                self?.hideActivityIndicator()
            }
            
        })
    }
}

fileprivate extension UIViewController {
    enum ActivityIndicatorConstants {
        static let activityIndicatorRestorationIdentifier: String = "ActivityIndicatorID"
        static let backgroundViewRestorationIdentifier: String = "ActivityBackgroundID"
        static let activityIndicatorSide: CGFloat = 80.0
        static let appearenceAnimationDuration: TimeInterval = 0.3
        static let backgroundAlpha: CGFloat = 0.1
    }
    
    func showActivityIndicator(){
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .charcoal.withAlphaComponent(ActivityIndicatorConstants.backgroundAlpha)
        backgroundView.alpha = 1
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundView)
        backgroundView.frame = view.bounds
        let activityIndicator = ActivityIndicator()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: ActivityIndicatorConstants.activityIndicatorSide),
            activityIndicator.heightAnchor.constraint(equalToConstant: ActivityIndicatorConstants.activityIndicatorSide),
            activityIndicator.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor)
        ])
        activityIndicator.restorationIdentifier = ActivityIndicatorConstants.activityIndicatorRestorationIdentifier
        backgroundView.restorationIdentifier = ActivityIndicatorConstants.backgroundViewRestorationIdentifier
        UIView.animate(withDuration: ActivityIndicatorConstants.appearenceAnimationDuration, animations: {
            backgroundView.alpha = 1
        }, completion: { _ in
            activityIndicator.start()
        })
    }
    
    func hideActivityIndicator(){
        for item in view.subviews where item.restorationIdentifier == ActivityIndicatorConstants.backgroundViewRestorationIdentifier{
            for activityIndicator in item.subviews where activityIndicator.restorationIdentifier == ActivityIndicatorConstants.activityIndicatorRestorationIdentifier{
                (activityIndicator as! ActivityIndicator).stop()
            }
            
            UIView.animate(withDuration: ActivityIndicatorConstants.appearenceAnimationDuration, animations: {
                item.alpha = 0.0
            }, completion: { _ in
                item.removeFromSuperview()
            })
        }
    }
}
