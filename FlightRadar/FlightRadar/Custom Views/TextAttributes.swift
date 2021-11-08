//
//  TextAttributes.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/28/21.
//

import Foundation
import UIKit

enum TextAttributes {
    static let smallRegularAttributes: [NSAttributedString.Key : Any] = [.font: UIFont.oswaldRegular(size: 20), .foregroundColor: UIColor.whiteLiliac, .strokeWidth: 5.0, .strokeColor: UIColor.charcoal, .kern: 2]
    static let buttonAttributes: [NSAttributedString.Key : Any] = [.font: UIFont.oswaldRegular(size: 20), .foregroundColor: UIColor.charcoal, .kern: 0]
    static let textFieldAttributes: [NSAttributedString.Key : Any] = [.font: UIFont.oswaldRegular(size: 26), .foregroundColor: UIColor.whiteLiliac, .strokeWidth: 5.0, .strokeColor: UIColor.charcoal, .kern: 2]
    
    static let smallMediumAttributes: [NSAttributedString.Key : Any] = [.font: UIFont.oswaldMedium(size: 16), .foregroundColor: UIColor.whiteLiliac, .strokeWidth: 5.0, .strokeColor: UIColor.charcoal, .kern: 2]
    static let averageMediumAttributes: [NSAttributedString.Key : Any] = [.font: UIFont.oswaldMedium(size: 20), .foregroundColor: UIColor.whiteLiliac, .strokeWidth: 5.0, .strokeColor: UIColor.charcoal, .kern: 2]
    static let averageRegularAttributes: [NSAttributedString.Key : Any] = [.font: UIFont.oswaldRegular(size: 24), .foregroundColor: UIColor.whiteLiliac, .strokeWidth: 5.0, .strokeColor: UIColor.charcoal, .kern: 2]
    static let largeMediumAttributes: [NSAttributedString.Key : Any] = [.font: UIFont.oswaldMedium(size: 36), .foregroundColor: UIColor.whiteLiliac, .strokeWidth: 5.0, .strokeColor: UIColor.charcoal, .kern: 2]
    static let smallLightAttributes: [NSAttributedString.Key : Any] = [.font: UIFont.oswaldLight(size: 18), .foregroundColor: UIColor.whiteLiliac, .strokeWidth: 5.0, .strokeColor: UIColor.charcoal, .kern: 4]
}
