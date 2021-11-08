//
//  BaseViewController.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/8/21.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let recognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(popController))
        recognizer.edges = .left
        recognizer.cancelsTouchesInView = false
        recognizer.delaysTouchesBegan = false
        recognizer.delaysTouchesEnded = false
        view.addGestureRecognizer(recognizer)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        hidesBottomBarWhenPushed = true
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        hidesBottomBarWhenPushed = true

    }

    @objc private func popController() {
        guard let navigationContoller = navigationController, navigationContoller.viewControllers.count > 1 else { return }
        navigationContoller.popViewController(animated: true)
    }
}
