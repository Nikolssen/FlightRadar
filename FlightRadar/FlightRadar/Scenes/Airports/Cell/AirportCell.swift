//
//  AirportCell.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/28/21.
//

import UIKit

final class AirportCell: UICollectionViewCell {
    private let airportView: AirportView = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func prepareForReuse() {
        airportView.distanceLabel.text = nil
        airportView.codeLabel.text = nil
        airportView.nameLabel.text = nil
    }
    
    
    private func commonInit() {
        contentView.addSubview(airportView)
        airportView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            airportView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            airportView.topAnchor.constraint(equalTo: contentView.topAnchor),
            airportView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            airportView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    func configure(with viewModel: AirportCellViewModelling) {
        
        if let distance = viewModel.distance {
            airportView.distanceLabel.text = distance
            airportView.distanceLabel.isHidden = false
        }
        else {
            airportView.distanceLabel.isHidden = true
        }
        
        airportView.codeLabel.text = viewModel.abbreviations
        airportView.nameLabel.text = viewModel.name
    }
}
