//
//  FlightController.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/8/21.
//

import UIKit

final class FlightController: UIViewController {
    @IBOutlet private var flightView: FlightView!
    @IBOutlet private var companyDescriptionLabel: MonochromeLabel!
    @IBOutlet private var departureDescriptionLabel: MonochromeLabel!
    
    @IBOutlet private var arrivalDescriptionLabel: MonochromeLabel!
    @IBOutlet private var departureAirportDescriptionLabel: MonochromeLabel!
    @IBOutlet private var arrivalAirportDescriptionLabel: MonochromeLabel!
    @IBOutlet private var companyLabel: MonochromeLabel!
    
    @IBOutlet private var departureLabel: MonochromeLabel!
    @IBOutlet private var arrivalLabel: MonochromeLabel!
    @IBOutlet private var departureAirportLabel: MonochromeLabel!
    @IBOutlet private var arrivalAirportLabel: MonochromeLabel!
    @IBOutlet private var companyButton: MonochromeButton!
    @IBOutlet private var aircraftButton: MonochromeButton!
    
    private var viewModel: FlightViewModelling!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAttributes()
        bind()
    }
    
    private func bind() {
        guard let viewModel = viewModel else { return }
        flightView.configure(with: viewModel.flightViewViewModel)
        
        if let company = viewModel.company  {
            companyDescriptionLabel.text = company
        }
        else {
            companyDescriptionLabel.isHidden = true
            companyLabel.isHidden = true
        }
        
        if let arrival = viewModel.arrival  {
            arrivalLabel.text = arrival
        }
        else {
            arrivalLabel.isHidden = true
            arrivalDescriptionLabel.isHidden = true
        }
       
        if let departure = viewModel.departure  {
            departureLabel.text = departure
        }
        else {
            departureLabel.isHidden = true
            departureDescriptionLabel.isHidden = true
        }
        
        aircraftButton.isHidden = !viewModel.isAircraftAvailable
        companyButton.isHidden = !viewModel.isCompanyAvailable
    }
    
    private func configureAttributes() {
        companyDescriptionLabel.text = Constants.companyDescription
        departureDescriptionLabel.text = Constants.departureDescription
        departureAirportDescriptionLabel.text = Constants.departureAirportDescription
        arrivalDescriptionLabel.text = Constants.arrivalDescription
        arrivalAirportDescriptionLabel.text = Constants.arrivalAirportDescription
        
        companyButton.setTitle(Constants.companyButtonDescription, for: .normal)
        aircraftButton.setTitle(Constants.aircraftButtonDescription, for: .normal)
        
        companyDescriptionLabel.attributes = TextAttributes.smallMediumAttributes
        companyLabel.attributes = TextAttributes.smallMediumAttributes
        departureDescriptionLabel.attributes = TextAttributes.smallMediumAttributes
        departureAirportDescriptionLabel.attributes = TextAttributes.smallMediumAttributes
        departureLabel.attributes = TextAttributes.smallMediumAttributes
        departureAirportLabel.attributes = TextAttributes.smallMediumAttributes
        arrivalDescriptionLabel.attributes = TextAttributes.smallMediumAttributes
        arrivalAirportDescriptionLabel.attributes = TextAttributes.smallMediumAttributes
        arrivalLabel.attributes = TextAttributes.smallMediumAttributes
        arrivalAirportLabel.attributes = TextAttributes.smallMediumAttributes
    }
    

    private enum Constants {
        static let companyDescription: String = "Company"
        static let departureDescription: String = "Departure"
        static let arrivalDescription: String = "Arrival"
        static let departureAirportDescription: String = "Departure Airport"
        static let arrivalAirportDescription: String = "Arrival Airport"
        static let companyButtonDescription: String = "More about \nthis company"
        static let aircraftButtonDescription: String = "More about \nthis aircraft"
    }
}
