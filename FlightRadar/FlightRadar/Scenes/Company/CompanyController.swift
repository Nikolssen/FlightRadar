//
//  CompanyController.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/7/21.
//

import UIKit

final class CompanyController: BaseViewController {
    @IBOutlet var titleLabel: MonochromeLabel!
    @IBOutlet var icaoLabel: MonochromeLabel!
    @IBOutlet var iataLabel: MonochromeLabel!
    @IBOutlet var iataCodeLabel: MonochromeLabel!
    @IBOutlet var icaoCodeLabel: MonochromeLabel!
    @IBOutlet var lowcosterLabel: MonochromeLabel!
    @IBOutlet var pageLabel: MonochromeButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    private func configure() {
        titleLabel.attributes = TextAttributes.largeMediumAttributes
        icaoLabel.attributes = TextAttributes.smallMediumAttributes
        iataLabel.attributes = TextAttributes.smallMediumAttributes
        iataCodeLabel.attributes = TextAttributes.smallMediumAttributes
        icaoCodeLabel.attributes = TextAttributes.smallMediumAttributes
        lowcosterLabel.attributes = TextAttributes.smallMediumAttributes
        
        icaoLabel.text = Constants.icaoDescription
        iataLabel.text = Constants.iataDescription
    }

    private enum Constants {
        static let icaoDescription: String = "ICAO Code"
        static let iataDescription: String = "IATA Code"
        static let lowcostDescription: String = "Lowcost carrier"
        static let pageDescription: String = "Official page"
    }
}

