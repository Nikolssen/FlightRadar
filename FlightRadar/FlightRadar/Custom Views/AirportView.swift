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
        return label
    }()
    
    lazy var codeLabel: MonochromeLabel = {
        let label = MonochromeLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributes = TextAttributes.averageMediumAttributes
        label.numberOfLines = 1
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    lazy var nameLabel: MonochromeLabel = {
        let label = MonochromeLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributes = TextAttributes.averageRegularAttributes
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var firstLevelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var secondLevelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 30
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
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
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 5
        
        addSubview(stackView)
        
        stackView.addArrangedSubview(firstLevelStackView)
        stackView.addArrangedSubview(secondLevelStackView)
        
        firstLevelStackView.addArrangedSubview(Spacer())
        firstLevelStackView.addArrangedSubview(distanceLabel)
        
        secondLevelStackView.addArrangedSubview(nameLabel)
        secondLevelStackView.addArrangedSubview(codeLabel)
    }
}
