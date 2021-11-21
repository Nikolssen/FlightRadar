//
//  FlightModalController.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/1/21.
//

import UIKit

final class FlightModalController: UIViewController {
    @IBOutlet private var companyLabel: MonochromeLabel!
    @IBOutlet private var companyNameLabel: MonochromeLabel!
    @IBOutlet private var departureLabel: MonochromeLabel!
    @IBOutlet private var departureDateLabel: MonochromeLabel!
    @IBOutlet private var arrivalLabel: MonochromeLabel!
    @IBOutlet private var arrivalDateLabel: MonochromeLabel!
    @IBOutlet private var flightView: FlightView!
    @IBOutlet var fullModeView: UIView!
    private let strokeLayer: CAShapeLayer = .init()
    private let shapeLayer: CAShapeLayer = .init()
    var viewModel: FlightModalViewModelling!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAttributes()

        configure()
    }
    
    @objc private func showFullMode() {
        viewModel.showFullMode.accept(Void())
    }

    @objc private func hide() {
        viewModel.hideRelay.accept(Void())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupBorders()
    }
    
    private func configure() {
        
        companyLabel.text = Constants.companyDescription
        departureLabel.text = Constants.departureDescription
        arrivalLabel.text = Constants.arrivalDescription
        
        if let company = viewModel.company  {
            companyNameLabel.text = company
        }
        else {
            companyNameLabel.isHidden = true
            companyLabel.isHidden = true
        }
        
        if let arrival = viewModel.arrival {
            arrivalDateLabel.text = arrival
        }
        else {
            arrivalLabel.isHidden = true
            arrivalDateLabel.isHidden = true
        }
        
        if let departure = viewModel.departure {
            departureDateLabel.text = departure
        }
        else {
            departureDateLabel.isHidden = true
            departureLabel.isHidden = true
        }
        
        flightView.configure(with: viewModel.flightViewViewModel)
        
        
        let upSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(showFullMode))
        upSwipeGesture.direction = .up
        upSwipeGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(upSwipeGesture)
        
        let downSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(hide))
        downSwipeGesture.direction = .down
        downSwipeGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(downSwipeGesture)
    }
    
    private func setupBorders() {
        shapeLayer.path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: Constants.cornerRadius, height: Constants.cornerRadius)).cgPath
        strokeLayer.path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: Constants.cornerRadius, height: Constants.cornerRadius)).cgPath
        strokeLayer.lineWidth = Constants.lineWidth
        strokeLayer.strokeColor = UIColor.charcoal.cgColor
        strokeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.frame = view.layer.bounds
        
        view.layer.mask = shapeLayer
        view.layer.addSublayer(strokeLayer)
        strokeLayer.frame = view.layer.bounds
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        strokeLayer.strokeColor = UIColor.charcoal.cgColor
        strokeLayer.fillColor = UIColor.clear.cgColor
    }
    
    private func configureAttributes() {
        
        companyLabel.attributes = TextAttributes.averageMediumAttributes
        companyNameLabel.attributes = TextAttributes.averageMediumAttributes
        departureLabel.attributes = TextAttributes.averageMediumAttributes
        departureDateLabel.attributes = TextAttributes.averageMediumAttributes
        arrivalLabel.attributes = TextAttributes.averageMediumAttributes
        arrivalDateLabel.attributes = TextAttributes.averageMediumAttributes
    }

    private enum Constants {
        static let companyDescription: String = "Company"
        static let departureDescription: String = "Departure"
        static let arrivalDescription: String = "Arrival"
        static let cornerRadius: CGFloat = 40
        static let lineWidth: CGFloat = 4
    }
}
