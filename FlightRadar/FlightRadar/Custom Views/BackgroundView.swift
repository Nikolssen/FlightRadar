//
//  BackgroundView.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/28/21.
//

import UIKit

class BackgroundView: UIView {

    @IBInspectable var cornerRadius: CGFloat  = Constants.initialCornerRadius {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    private func commonInit() {
        layer.cornerCurve = .continuous
        layer.cornerRadius = cornerRadius
        backgroundColor = .athensGray
        layer.borderWidth = Constants.borderWidth
        layer.borderColor = UIColor.charcoal.cgColor
    }
    
    private enum Constants {
        static let borderWidth: CGFloat = 2
        static let initialCornerRadius: CGFloat = 10
    }
}
