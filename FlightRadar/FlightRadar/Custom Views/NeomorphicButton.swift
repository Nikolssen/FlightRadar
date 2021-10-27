//
//  NeomorphicButton.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/27/21.
//

import UIKit

class NeomorphicButton: SanMarinoButton {

    override var isHighlighted: Bool {
        willSet {
            contentView.innerShadow = newValue
        }
    }
    
    private lazy var contentView: NeomorphicView = {
        let view = NeomorphicView()
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
        contentView.innerShadow = false
        insertSubview(contentView, at: 0)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.isUserInteractionEnabled = false
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            contentView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
        ])
        titleEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    
    override var intrinsicContentSize: CGSize {
        let superSize = super.intrinsicContentSize
        return CGSize(width: superSize.width + Constants.insets.left + Constants.insets.right, height: superSize.height + Constants.insets.top + Constants.insets.bottom)
    }
    
    private enum Constants {
        static let insets: UIEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
}
