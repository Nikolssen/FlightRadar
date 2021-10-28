//
//  TabBar.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/27/21.
//

import UIKit
import SwiftUI

class TabBar: UIView {

    var items: [TabBarItem] = []
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .athensGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var itemsView: NeomorphicView = {
        let view = NeomorphicView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func commonInit() {
        addSubview(contentView)
        contentView.addSubview(itemsView)
        itemsView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            contentView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            itemsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            itemsView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            itemsView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            itemsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: itemsView.leadingAnchor, constant: 10),
            stackView.centerXAnchor.constraint(equalTo: itemsView.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: itemsView.topAnchor),
            stackView.centerYAnchor.constraint(equalTo: itemsView.bottomAnchor)
        ])
    }
}


