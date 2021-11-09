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
    
    // Should've been refactored but I am lazy
    static func color(for altitude: Double) -> UIColor {
        switch altitude {
        case let x where x <= 0:
            return ground
        case let x where x <= 2 && x > 0:
            let ratio = (2 - x) / 2
            let red = (twoKm.ciColor.red * ratio + ground.ciColor.red * (1 - ratio)) / 2
            let green = (twoKm.ciColor.green * ratio + ground.ciColor.green * (1 - ratio)) / 2
            let blue = (twoKm.ciColor.blue * ratio + ground.ciColor.blue * (1 - ratio)) / 2
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        case let x where x <= 4 && x > 2:
            let ratio = (4 - x) / 2
            let red = (fourKm.ciColor.red * ratio + twoKm.ciColor.red * (1 - ratio)) / 2
            let green = (fourKm.ciColor.green * ratio + twoKm.ciColor.green * (1 - ratio)) / 2
            let blue = (fourKm.ciColor.blue * ratio + twoKm.ciColor.blue * (1 - ratio)) / 2
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        case let x where x <= 6 && x > 4:
            let ratio = (6 - x) / 2
            let red = (sixKm.ciColor.red * ratio + fourKm.ciColor.red * (1 - ratio)) / 2
            let green = (sixKm.ciColor.green * ratio + fourKm.ciColor.green * (1 - ratio)) / 2
            let blue = (sixKm.ciColor.blue * ratio + fourKm.ciColor.blue * (1 - ratio)) / 2
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        case let x where x <= 8 && x > 6:
            let ratio = (8 - x) / 2
            let red = (eightKm.ciColor.red * ratio + sixKm.ciColor.red * (1 - ratio)) / 2
            let green = (eightKm.ciColor.green * ratio + sixKm.ciColor.green * (1 - ratio)) / 2
            let blue = (eightKm.ciColor.blue * ratio + sixKm.ciColor.blue * (1 - ratio)) / 2
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        case let x where x <= 10 && x > 8:
            let ratio = (10 - x) / 2
            let red = (tenKm.ciColor.red * ratio + eightKm.ciColor.red * (1 - ratio)) / 2
            let green = (tenKm.ciColor.green * ratio + eightKm.ciColor.green * (1 - ratio)) / 2
            let blue = (tenKm.ciColor.blue * ratio + eightKm.ciColor.blue * (1 - ratio)) / 2
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        case let x where x < 12 && x > 10:
            let ratio = (12 - x) / 2
            let red = (twelveKm.ciColor.red * ratio + tenKm.ciColor.red * (1 - ratio)) / 2
            let blue = (twelveKm.ciColor.blue * ratio + tenKm.ciColor.blue * (1 - ratio)) / 2
            let green = (twelveKm.ciColor.green * ratio + tenKm.ciColor.green * (1 - ratio)) / 2
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        default:
            return twelveKm
        }
    }
}
