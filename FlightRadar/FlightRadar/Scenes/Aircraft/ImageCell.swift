//
//  ImageCell.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/8/21.
//

import UIKit

class ImageCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerCurve = .continuous
        layer.cornerRadius = 18
        layer.borderColor = UIColor.charcoal.cgColor
        layer.borderWidth = 1
        layer.masksToBounds = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func configure(with url: URL) {
        
    }
}
