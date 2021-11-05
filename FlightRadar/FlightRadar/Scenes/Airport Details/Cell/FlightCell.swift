//
//  FlightCell.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/2/21.
//

import UIKit

final class FlightCell: UICollectionViewCell {
    
    lazy private var flightView: FlightView = {
        let view = FlightView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func commonInit() {
        contentView.addSubview(flightView)
        NSLayoutConstraint.activate([
            flightView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            flightView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            flightView.topAnchor.constraint(equalTo: contentView.topAnchor),
            flightView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func configure(with viewModel: FlightViewViewModelling) {
        flightView.configure(with: viewModel)
    }
    
}
