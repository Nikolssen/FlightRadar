//
//  AirportView.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/28/21.
//

import UIKit

final class AirportView: BackgroundView {
    
    lazy var distanceLabel: MonochromeLabel = {
       let label = MonochromeLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributes = TextAttributes.smallMediumAttributes
        label.numberOfLines = 1
        label.textAlignment = .right
        return label
    }()
    
    lazy var codeLabel: MonochromeLabel = {
        let label = MonochromeLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributes = TextAttributes.averageMediumAttributes
        label.numberOfLines = 1
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.textAlignment = .right
        return label
    }()
    
    lazy var nameLabel: MonochromeLabel = {
        let label = MonochromeLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributes = TextAttributes.averageRegularAttributes
        label.numberOfLines = 0
        return label
    }()
    
    
    private lazy var secondLevelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 15
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        return stackView
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
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        stackView.spacing = 5
        
        addSubview(stackView)
        
        stackView.addArrangedSubview(distanceLabel)
        stackView.addArrangedSubview(secondLevelStackView)
        
        secondLevelStackView.addArrangedSubview(nameLabel)
        secondLevelStackView.addArrangedSubview(codeLabel)
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
