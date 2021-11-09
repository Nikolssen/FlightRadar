//
//  FlightController.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/8/21.
//

import UIKit

final class FlightController: UIViewController {
    @IBOutlet private var flightView: FlightView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    private enum Constants {
        static let companyDescription: String = "Company"
        static let departureDescription: String = "Departure"
        static let arrivalDescription: String = "Arrival"
        static let aircraftNumberDescription: String = "Aircraft registration number"
        static let departureAirportDescription: String = "Departure Airport"
        static let arrivalAirportDescription: String = "Arrival Airport"
        static let companyButtonDescription: String = "More about this company"
        static let aircraftButtonDescription: String = "More about this aircraft"
    }
}
