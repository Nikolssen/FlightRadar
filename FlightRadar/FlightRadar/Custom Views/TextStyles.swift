//
//  TextStyles.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/28/21.
//

import Foundation
import UIKit

enum TextStyles {
    static let buttonAttributes: [NSAttributedString.Key : Any] = [.font: UIFont.oswaldRegular(size: 20), .foregroundColor: UIColor.whiteLiliac, .strokeWidth: 5.0, .strokeColor: UIColor.charcoal, .kern: 2]
    static let highlightedButtonAttributed: [NSAttributedString.Key : Any] = [.font: UIFont.oswaldRegular(size: 20), .foregroundColor: UIColor.charcoal, .kern: 2]
    static let textFieldAttributes: [NSAttributedString.Key : Any] = [.font: UIFont.oswaldRegular(size: 26), .foregroundColor: UIColor.whiteLiliac, .strokeWidth: 5.0, .strokeColor: UIColor.charcoal, .kern: 2]
    static let smallMediumAttributes: [NSAttributedString.Key : Any] = [.font: UIFont.oswaldMedium(size: 16), .foregroundColor: UIColor.whiteLiliac, .strokeWidth: 5.0, .strokeColor: UIColor.charcoal, .kern: 2]
}
