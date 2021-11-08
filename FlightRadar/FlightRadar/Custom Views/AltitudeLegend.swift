//
//  AltitudeLegend.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/3/21.
//

import UIKit

class AltitudeLegend: UIView {

    lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [AltitudeHeight.ground.cgColor, AltitudeHeight.twoKm.cgColor, AltitudeHeight.fourKm.cgColor, AltitudeHeight.sixKm.cgColor, AltitudeHeight.eightKm.cgColor, AltitudeHeight.tenKm.cgColor, AltitudeHeight.twelveKm.cgColor].reversed()
        return layer
    }()
    
    lazy var topLabel: UILabel = {
        let label = UILabel()
        label.font = .oswaldLight(size: 12)
        label.textColor = .whiteLiliac
        label.text = "12"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var bottomLabel: UILabel = {
        let label = UILabel()
        label.font = .oswaldLight(size: 12)
        label.textColor = .whiteLiliac
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        
        layer.cornerRadius = 5
        layer.cornerCurve = .continuous
        layer.masksToBounds = true
        
        layer.addSublayer(gradientLayer)
        addSubview(topLabel)
        addSubview(bottomLabel)
        NSLayoutConstraint.activate([
            topLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            topLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            bottomLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            bottomLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
            
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = layer.bounds
    }
}

enum AltitudeHeight {
    static let ground: UIColor = #colorLiteral(red: 0.5416108966, green: 0.131835103, blue: 0.7479419112, alpha: 1)
    static let twoKm: UIColor = #colorLiteral(red: 0.1604626775, green: 0.098075293, blue: 0.9293354154, alpha: 1)
    static let fourKm: UIColor = #colorLiteral(red: 0.2025648057, green: 0.9671089053, blue: 0.9775189757, alpha: 1)
    static let sixKm: UIColor = #colorLiteral(red: 0.5495851636, green: 0.9948977828, blue: 0.08869222552, alpha: 1)
    static let eightKm: UIColor = #colorLiteral(red: 0.9917758107, green: 0.9779286981, blue: 0.0002748265979, alpha: 1)
    static let tenKm: UIColor = #colorLiteral(red: 0.9834459424, green: 0.01795159094, blue: 0.003998221364, alpha: 1)
    static let twelveKm: UIColor = #colorLiteral(red: 0.6144523025, green: 0.01183649711, blue: 0.01088715158, alpha: 1)
}
