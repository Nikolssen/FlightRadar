//
//  NeomorphicView.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/26/21.
//

import UIKit

final class NeomorphicView : UIView
{
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Constants.backgroundColor
        return view
    }()
    
    @IBInspectable public var cornerRadius: CGFloat = 10
    
    private var shadowColor1: UIColor = UIColor.lightGray

    private var shadowColor2: UIColor = UIColor.white
    
    @IBInspectable var innerShadow: Bool = true{
        didSet{
            if innerShadow{
                setInnerShadow()
            }
            else {
                setOuterShadow()
            }
        }
    }
    
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
        
        self.addSubview(containerView)
        configureLayout()
        self.sendSubviewToBack(self.containerView)
        
        layer.masksToBounds = false
        containerView.layer.masksToBounds = false
        
        layer.cornerCurve = .continuous
        containerView.layer.cornerCurve = .continuous
        
        layer.shadowOffset = Constants.shadow2Size
        layer.shadowOpacity = Constants.shadowOpacity
        layer.shadowRadius = Constants.shadowRadius
        
        containerView.layer.shadowOpacity = Constants.shadowOpacity
        containerView.layer.shadowRadius = Constants.shadowRadius
        containerView.backgroundColor = Constants.backgroundColor
        containerView.layer.shadowOffset = Constants.shadow1Size;
        
        self.backgroundColor = Constants.backgroundColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = cornerRadius
        containerView.layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowColor = shadowColor1.cgColor
        layer.shadowPath = shadowPath.cgPath

        let shadowPath1 = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        containerView.layer.shadowColor = shadowColor2.cgColor
        containerView.layer.shadowPath = shadowPath1.cgPath
    
        
       
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            containerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
        ])

     }
    

   private func setInnerShadow(){
       shadowColor2 = Constants.lightShadowColor
       shadowColor1 = Constants.darkShadowColor
       self.layoutIfNeeded()
    }
    
    private func setOuterShadow(){
        shadowColor1 = Constants.lightShadowColor
        shadowColor2 = Constants.darkShadowColor
        self.layoutIfNeeded()
    }
    
    private enum Constants {
        static let backgroundColor: UIColor = .whiteLiliac
        static let darkShadowColor: UIColor = .charcoal.withAlphaComponent(0.5)
        static let lightShadowColor: UIColor = .white.withAlphaComponent(0.8)
        static let shadowRadius: CGFloat = 4.0
        static let shadowOpacity: Float = 1.0
        static let shadow1Size = CGSize(width: 3, height: 3)
        static let shadow2Size = CGSize(width: -3, height: -3)
    }
}
