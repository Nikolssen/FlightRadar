//
//  MonochromeLabel.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/28/21.
//

import UIKit

class MonochromeLabel: UILabel {
    
    var attributes: [NSAttributedString.Key : Any] = [:]
    override var text: String? {
        willSet {
            if let value = newValue {
                attributedText = NSAttributedString(string: value, attributes: attributes)
            }
            else {
                attributedText = nil
            }
        }
    }
}
