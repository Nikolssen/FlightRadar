//
//  MonochromeButton.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/27/21.
//

import UIKit

final class MonochromeButton: UIButton {
    
    override var isHighlighted: Bool {
        willSet {
            contentView.backgroundColor = newValue ? .whiteLiliac : .athensGray
        }
    }
    
    private lazy var contentView: BackgroundView = {
        let view = BackgroundView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        
        insertSubview(contentView, at: 0)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.isUserInteractionEnabled = false
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        titleEdgeInsets = Constants.insets
        
        setAttributedTitle(NSAttributedString(string: title(for: .normal) ?? "", attributes: TextAttributes.buttonAttributes), for: .normal)
        setAttributedTitle(NSAttributedString(string: title(for: .highlighted) ?? "", attributes: TextAttributes.highlightedButtonAttributed), for: .highlighted)
    }
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        switch state {
        case .normal:
            setAttributedTitle(NSAttributedString(string: title ?? "", attributes: TextAttributes.buttonAttributes), for: .normal)
            
        case .highlighted:
            setAttributedTitle(NSAttributedString(string: title ?? "", attributes: TextAttributes.highlightedButtonAttributed), for: .highlighted)
        default:
            super.setTitle(title, for: state)
        }
        
    }
    
    override var intrinsicContentSize: CGSize {
        let superSize = super.intrinsicContentSize
        return CGSize(width: superSize.width + Constants.insets.left + Constants.insets.right, height: superSize.height + Constants.insets.top + Constants.insets.bottom)
    }
    
    private enum Constants {
        static let insets: UIEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
}
