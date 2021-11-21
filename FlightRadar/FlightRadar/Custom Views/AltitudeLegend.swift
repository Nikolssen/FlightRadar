//
//  AltitudeLegend.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/3/21.
//

import UIKit

final class AltitudeLegend: UIView {

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
    
    static func color(for altitude: Double) -> UIColor {
        switch altitude {
        case let x where x <= 0:
            return ground
        case let x where x <= 2 && x > 0:
            let ratio = (2 - x) / 2
            return borderColor(with: ratio, lowColor: ground, topColor: twoKm)
        case let x where x <= 4 && x > 2:
            let ratio = (4 - x) / 2
            return borderColor(with: ratio, lowColor: twoKm, topColor: fourKm)
        case let x where x <= 6 && x > 4:
            let ratio = (6 - x) / 2
            return borderColor(with: ratio, lowColor: fourKm, topColor: sixKm)
        case let x where x <= 8 && x > 6:
            let ratio = (8 - x) / 2
            return borderColor(with: ratio, lowColor: sixKm, topColor: eightKm)
        case let x where x <= 10 && x > 8:
            let ratio = (10 - x) / 2
            return borderColor(with: ratio, lowColor: eightKm, topColor: tenKm)
        case let x where x < 12 && x > 10:
            let ratio = (12 - x) / 2
            return borderColor(with: ratio, lowColor: tenKm, topColor: twelveKm)
        default:
            return twelveKm
        }
    }
    
    static func borderColor(with ratio: CGFloat, lowColor: UIColor, topColor: UIColor) -> UIColor {
        var red1: CGFloat = 0
        var green1: CGFloat = 0
        var blue1: CGFloat = 0
        
        var red2: CGFloat = 0
        var green2: CGFloat = 0
        var blue2: CGFloat = 0
        
        topColor.getRed(&red1, green: &green1, blue: &blue1, alpha: nil)
        lowColor.getRed(&red2, green: &green2, blue: &blue2, alpha: nil)
        
        let red = red1 * ratio + red2 * (1 - ratio)
        let green = green1 * ratio + green2 * (1 - ratio)
        let blue = blue1 * ratio + blue2 * (1 - ratio)
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
