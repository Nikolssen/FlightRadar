//
//  Rx+AlertController.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/9/21.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

extension UIViewController {
    var alertControllerBinder: Binder<(title: String, message: String)?>{
        return Binder(self, binding: { [weak self] (viewController, info) in
            guard let info = info else { return }
            let alertController = UIAlertController(title: info.title, message: info.message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            self?.present(alertController, animated: true, completion: nil)
        })
    }
}
