//
//  MonochromeLabel.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/28/21.
//

import UIKit

final class MonochromeLabel: UILabel {
    
    var attributes: [NSAttributedString.Key : Any] = [:] {
        didSet {
            let text = text
            self.text = nil
            self.text = text
        }
    }
    override var text: String? {
        didSet {
            if let value = text {
                attributedText = nil
                attributedText = NSAttributedString(string: value, attributes: attributes)
            }
            else {
                attributedText = nil
            }
        }
    }
}
