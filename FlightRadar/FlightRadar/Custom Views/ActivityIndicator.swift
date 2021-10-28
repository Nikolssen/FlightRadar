//
//  ActivityIndicator.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/28/21.
//

import UIKit

class ActivityIndicator: BackgroundView {

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
    
    func start() {
    
        spinnerLayer.removeAnimation(forKey: Constants.animationName)
        let animation = CABasicAnimation(keyPath: Constants.keypath)
        animation.fromValue = 0
        animation.toValue =  2 * Float.pi
        animation.duration = 2
        animation.repeatDuration = .infinity
        spinnerLayer.add(animation, forKey: Constants.animationName)
    }
    
    func stop() {
        spinnerLayer.removeAnimation(forKey: Constants.animationName)
    }
    
    private enum Constants {
        static let animationName = "Spinner"
        static let keypath = "transform.rotation.z"
    }

}
