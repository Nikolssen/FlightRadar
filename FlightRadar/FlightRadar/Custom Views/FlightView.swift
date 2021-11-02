//
//  FlightView.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/28/21.
//

import UIKit

final class FlightView: BackgroundView {
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.alignment = .fill
        stackView.spacing = 15
        return stackView
    }()
    
    private lazy var originStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var destinationStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()
    
    lazy var originCodeLabel: UILabel = {
        let label = MonochromeLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.attributes = TextAttributes.largeRegularAttributes
        return label
    }()
    
    lazy var destinationCodeLabel: UILabel = {
        let label = MonochromeLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.attributes = TextAttributes.largeRegularAttributes
        return label
    }()
    
    lazy var originLabel: UILabel = {
        let label = MonochromeLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributes = TextAttributes.smallLightAttributes
        label.numberOfLines = 2
        return label
    }()
    
    lazy var destinationLabel: UILabel = {
        let label = MonochromeLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributes = TextAttributes.smallLightAttributes
        label.numberOfLines = 2
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = MonochromeLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributes = TextAttributes.smallMediumAttributes
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func commonInit() {
        addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(originStackView)
        horizontalStackView.addArrangedSubview(timeLabel)
        horizontalStackView.addArrangedSubview(destinationStackView)
        originStackView.addArrangedSubview(originCodeLabel)
        originStackView.addArrangedSubview(originLabel)
        destinationStackView.addArrangedSubview(destinationCodeLabel)
        destinationStackView.addArrangedSubview(destinationLabel)
        
        NSLayoutConstraint.activate([
            horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            horizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            horizontalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
