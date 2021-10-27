//
//  SanMarinoButton.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/27/21.
//

import UIKit

class SanMarinoButton: UIButton {

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
        
        setTitleColor(.sanMarino, for: .normal)
        setTitleColor(.manhattan, for: .highlighted)
        tintColor = .sanMarino
    }
    
}
