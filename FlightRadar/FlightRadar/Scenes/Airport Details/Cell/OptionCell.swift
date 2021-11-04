//
//  OptionCell.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/2/21.
//

import UIKit

final class OptionCell: UICollectionViewCell {
    
    
    override var isSelected: Bool {
        didSet {
            label.attributes = isSelected ? TextAttributes.buttonAttributes : TextAttributes.smallRegularAttributes
        }
    }

    lazy var label: MonochromeLabel = {
        let label = MonochromeLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributes = isSelected ? TextAttributes.buttonAttributes : TextAttributes.smallRegularAttributes
        return label
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit(){
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: label.centerYAnchor)])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    static func size(for text: String) -> CGSize {
        let size = text.size(withAttributes: TextAttributes.smallRegularAttributes)
        return CGSize(width: size.width + 15, height: size.height)
    }

}
