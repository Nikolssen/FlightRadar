//
//  UIImage + Custom Images.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/26/21.
//

import UIKit
extension UIImage {
    static let logo = UIImage(named: "logo")
    static let plane = UIImage(named: "plane")
    static let airport = UIImage(named: "airport")
    
    static let airports = UIImage(named: "airports")
    static let tickets = UIImage(named: "ticket")
    static let map = UIImage(named: "map")
    
    static let magnifyingGlass = UIImage(systemName: "magnifyingglass")
    static let star = UIImage(systemName: "star")
    static let filledStar = UIImage(systemName: "star.fill")
    static let airplane = UIImage(systemName: "airplane")
    
    func imageRotatedByDegrees(degrees: CGFloat, flip: Bool, color: UIColor) -> UIImage {
        
        let degreesToRadians: (CGFloat) -> CGFloat = {
            return $0 / 180.0 * CGFloat.pi
        }
        
        // calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox = UIView(frame: CGRect(origin: .zero, size: size))
        let t = CGAffineTransform(rotationAngle: degreesToRadians(degrees));
        rotatedViewBox.transform = t
        let rotatedSize = rotatedViewBox.frame.size
        
        // Create the bitmap context
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap = UIGraphicsGetCurrentContext()
        
        // Move the origin to the middle of the image so we will rotate and scale around the center.
        bitmap?.translateBy(x: rotatedSize.width / 2.0, y: rotatedSize.height / 2.0)
        
        //   // Rotate the image context
        bitmap?.rotate(by: degreesToRadians(degrees))
        
        // Now, draw the rotated/scaled image into the context
        var yFlip: CGFloat
        
        if(flip){
            yFlip = CGFloat(-1.0)
        } else {
            yFlip = CGFloat(1.0)
        }
        
        bitmap?.scaleBy(x: yFlip, y: -1.0)
        let rect = CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height)
        
        bitmap?.draw(cgImage!, in: rect)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
