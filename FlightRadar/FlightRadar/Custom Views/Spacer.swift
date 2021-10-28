//
//  Spacer.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/28/21.
//

import UIKit

class Spacer: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        let widthConstraint = widthAnchor.constraint(equalToConstant: .greatestFiniteMagnitude)
        widthConstraint.priority = .defaultLow
        widthConstraint.isActive = true
    }
}
