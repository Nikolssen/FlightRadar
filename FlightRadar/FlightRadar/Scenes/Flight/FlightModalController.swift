//
//  FlightModalController.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/1/21.
//

import UIKit

class FlightModalController: UIViewController {
    @IBOutlet private var companyLabel: MonochromeLabel!
    @IBOutlet private var companyNameLabel: MonochromeLabel!
    @IBOutlet private var departureLabel: MonochromeLabel!
    @IBOutlet private var departureDateLabel: MonochromeLabel!
    @IBOutlet private var arrivalLabel: MonochromeLabel!
    @IBOutlet private var arrivalDateLabel: MonochromeLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAttributes()
        setupBorders()
    }
    
    private func setupBorders() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 40, height: 40)).cgPath
        let strokeLayer = CAShapeLayer()
        strokeLayer.path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 40, height: 40)).cgPath
        strokeLayer.lineWidth = 1
        strokeLayer.strokeColor = UIColor.charcoal.cgColor
        strokeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.frame = view.layer.bounds
        
        view.layer.mask = shapeLayer
        view.layer.addSublayer(strokeLayer)
        strokeLayer.frame = view.layer.bounds
    }
    
    private func configureAttributes() {
        
        companyLabel.attributes = TextAttributes.smallMediumAttributes
        companyNameLabel.attributes = TextAttributes.smallMediumAttributes
        departureLabel.attributes = TextAttributes.smallMediumAttributes
        departureDateLabel.attributes = TextAttributes.smallMediumAttributes
        arrivalLabel.attributes = TextAttributes.smallMediumAttributes
        arrivalDateLabel.attributes = TextAttributes.smallMediumAttributes
    }

}
