//
//  UIFont + Custom Fonts.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/26/21.
//

import UIKit

extension UIFont {
    static func gnuolane(size: CGFloat) -> UIFont {
        if Locale.current.identifier.starts(with: "ru")  {
            return UIFont(name: "Oswald-Regular", size: size)!
        }
        return UIFont(name: "Gnuolane", size: size)!
    }
    
    static func oswaldLight(size: CGFloat) -> UIFont {
        UIFont(name: "Oswald-Light", size: size)!
    }
    
    static func oswaldRegular(size: CGFloat) -> UIFont {
        UIFont(name: "Oswald-Regular", size: size)!
    }
    
    static func oswaldMedium(size: CGFloat) -> UIFont {
        UIFont(name: "Oswald-Medium", size: size)!
    }
}
