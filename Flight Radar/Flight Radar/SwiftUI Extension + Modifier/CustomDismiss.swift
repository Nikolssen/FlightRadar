//
//  CustomDismiss.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 12/13/21.
//

import SwiftUI

extension EnvironmentValues {

    /// An indication whether a view is currently presented by another view.
    ///
    /// Mimics behaviour of `SwiftUI.CustomPresentationMode`, supposed to be used in custom navigation.
    /// Currently supported by `customSheet`.
    struct CustomPresentationMode {

        private let dismissAction: (() -> Void)?
        var isPresented: Bool { dismissAction != nil }

        init(dismissAction: (() -> Void)? = nil) {
            self.dismissAction = dismissAction
        }
        
        /// Call when you need to present SwiftUI Coordinator from UIKit
        init(_ hostingControllerPresenter: UIViewController) {
            self.dismissAction = {
                if let presentedViewController = hostingControllerPresenter.presentedViewController,
                   !presentedViewController.isBeingDismissed {
                    hostingControllerPresenter.dismiss(animated: true, completion: nil)
                }
            }
        }
        
        func dismiss() {
            dismissAction?()
        }
    }

    private struct PresentationEnvironmentKey: EnvironmentKey {
        static let defaultValue = CustomPresentationMode()
    }

    var customPresentationMode: CustomPresentationMode {
        get { self[PresentationEnvironmentKey.self] }
        set { self[PresentationEnvironmentKey.self] = newValue }
    }
}
