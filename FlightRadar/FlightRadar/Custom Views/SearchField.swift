//
//  SearchField.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/27/21.
//

import UIKit

final class SearchField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    private func commonInit() {
        tintColor = .charcoal
        borderStyle = .none
        let image = UIImage.magnifyingGlass?.applyingSymbolConfiguration(.init(pointSize: 26, weight: .bold))
        
        let imageView = UIImageView(image: image)
        imageView.tintColor = .charcoal
        imageView.contentMode = .center
        leftView = imageView
        leftViewMode = .always
        
        let contentView = BackgroundView()
        insertSubview(contentView, at: 0)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.isUserInteractionEnabled = false
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        contentView.cornerRadius = Constants.cornerRadius
        
        defaultTextAttributes = TextAttributes.textFieldAttributes
        
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: Constants.inset)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: Constants.inset)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: Constants.inset)
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        CGRect(x: Constants.leftViewLeftInset, y: Constants.leftViewVerticalInset, width: Constants.leftViewWidth, height: bounds.height - 2 * Constants.leftViewVerticalInset)
    }
    
    override var intrinsicContentSize: CGSize {
        let superSize = super.intrinsicContentSize
        return CGSize(width: superSize.width + Constants.inset.left + Constants.inset.right, height: superSize.height + Constants.inset.top + Constants.inset.bottom)
    }
    
    private enum Constants {
        static let inset: UIEdgeInsets = .init(top: 5, left: 50, bottom: 5, right: 10)
        static let leftViewVerticalInset: CGFloat = 5
        static let leftViewLeftInset: CGFloat = 5
        static let leftViewWidth: CGFloat = 40
        static let cornerRadius: CGFloat = 10
    }
    
    
}
