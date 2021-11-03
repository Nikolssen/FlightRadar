//
//  AirportCell.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/28/21.
//

import UIKit

final class AirportCell: UITableViewCell {
    private let airportView: AirportView = .init()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        backgroundColor = .athensGray
        NSLayoutConstraint.activate([
            airportView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            airportView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            airportView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            airportView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    func configure(with viewModel: AirportViewViewModelling) {
        
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
