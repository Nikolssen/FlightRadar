//
//  ActivityIndicator.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/28/21.
//

import UIKit

final class ActivityIndicator: BackgroundView {

    private lazy var spinnerLayer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        let bezierPath = UIBezierPath(arcCenter: CGPoint(x: bounds.width / 2, y: bounds.height / 2), radius: 20, startAngle: 0, endAngle: CGFloat(0.5 * .pi), clockwise: true).cgPath
        shapeLayer.path = bezierPath
        shapeLayer.strokeColor = UIColor.charcoal.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 8
        shapeLayer.lineCap = .round
        shapeLayer.lineJoin = .round
        return shapeLayer
    }()
    
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
        backgroundColor = .whiteLiliac
        layer.addSublayer(spinnerLayer)
        cornerRadius = 20
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        spinnerLayer.path = UIBezierPath(arcCenter: CGPoint(x: bounds.width / 2, y: bounds.height / 2), radius: 20, startAngle: CGFloat(0), endAngle: CGFloat(1.6 * .pi), clockwise: true).cgPath
        spinnerLayer.frame = layer.bounds
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        spinnerLayer.strokeColor = UIColor.charcoal.cgColor
        spinnerLayer.fillColor = UIColor.clear.cgColor
    }
    
    func start() {
    
        spinnerLayer.removeAnimation(forKey: Constants.animationName)
        let animation = CABasicAnimation(keyPath: Constants.keypath)
        animation.fromValue = Constants.startValue
        animation.toValue =  Constants.endValue
        animation.duration = Constants.animationDuration
        animation.repeatDuration = .infinity
        spinnerLayer.add(animation, forKey: Constants.animationName)
    }
    
    func stop() {
        spinnerLayer.removeAnimation(forKey: Constants.animationName)
    }
    
    private enum Constants {
        static let animationName = "Spinner"
        static let keypath = "transform.rotation.z"
        static let animationDuration: CFTimeInterval = 2
        static let startValue: CGFloat = 0
        static let endValue: CGFloat = CGFloat(2 * Float.pi)
    }

}
