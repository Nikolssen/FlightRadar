//
//  OptionCell.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/2/21.
//

import UIKit

final class OptionCell: UICollectionViewCell {
    
    @IBOutlet var label: MonochromeLabel!
    
    override var isSelected: Bool {
        willSet {
            label.attributes = newValue ? TextAttributes.buttonAttributes : TextAttributes.smallRegularAttributes
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        label.attributes = isSelected ? TextAttributes.buttonAttributes : TextAttributes.smallRegularAttributes
    }

}
