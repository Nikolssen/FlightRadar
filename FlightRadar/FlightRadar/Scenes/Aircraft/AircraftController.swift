//
//  AircraftController.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/7/21.
//

import UIKit

class AircraftController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    

    private enum Constants {
        static let aircraftRegistrationDescription: String = "Aircraft registration number"
        static let aircraftIcaoDescription: String = "Aircraft ICAO number"
        static let companyDescription: String = "Company"
        static let numberOfEnginesDescription: String = "Number of Engines"
        static let ageDescription: String = "Age"
        static let firstFlightDescription: String = "First flight"
        static let numberOfSeatsDescription: String = "Number of seats"
    }
}
