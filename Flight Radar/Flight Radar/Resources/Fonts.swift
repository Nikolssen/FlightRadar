//
//  Fonts.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/14/21.
//

import SwiftUI

extension Font {
    static func gnuolane(size: CGFloat) -> Font {
        Font.custom("Gnuolane", size: size)
    }
    
    static func oswaldLight(size: CGFloat) -> Font {
        Font.custom("Oswald-Light", size: size)
    }
    
    static func oswaldRegular(size: CGFloat) -> Font {
        Font.custom("Oswald-Regular", size: size)
    }
    
    static func oswaldMedium(size: CGFloat) -> Font {
        Font.custom("Oswald-Medium", size: size)
    }
}
