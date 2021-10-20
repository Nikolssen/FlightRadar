//
//  CorneredRectangle.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/20/21.
//

import SwiftUI

struct CornerRectangle: Shape {
    
    var cornerRadius: CGFloat
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        Path(UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath)
    }
    
    init(cornerRadius: CGFloat, byRoundingCorners: UIRectCorner) {
        self.cornerRadius = cornerRadius
        self.corners = byRoundingCorners
    }
}
