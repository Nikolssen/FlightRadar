//
//  FlightController.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/8/21.
//

import UIKit
import RxSwift
import RxCocoa

final class FlightController: BaseViewController {
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
    
    private let disposeBag = DisposeBag()
    var viewModel: FlightViewModelling!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAttributes()
        bind()
    }
    
    private func bind() {
        guard let viewModel = viewModel else { return }
        flightView.configure(with: viewModel.flightViewViewModel)
        
        if let company = viewModel.company  {
            companyLabel.text = company
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
        
        if let departureAirport = viewModel.departureAirport  {
            departureAirportLabel.text = departureAirport
        }
        else {
            departureAirportLabel.isHidden = true
            departureAirportDescriptionLabel.isHidden = true
        }
        
        if let arrivalAirport = viewModel.arrivalAirport  {
            arrivalAirportLabel.text = arrivalAirport
        }
        else {
            arrivalAirportLabel.isHidden = true
            arrivalAirportDescriptionLabel.isHidden = true
        }
        
        aircraftButton.isHidden = !viewModel.isAircraftAvailable
        companyButton.isHidden = !viewModel.isCompanyAvailable
        
        aircraftButton.rx
            .tap
            .bind(to: viewModel.aircraftSelectionRelay)
            .disposed(by: disposeBag)
        
        companyButton.rx
            .tap
            .debug()
            .bind(to: viewModel.companySelectionRelay)
            .disposed(by: disposeBag)
    }
    
    private func configureAttributes() {
        companyDescriptionLabel.text = Constants.companyDescription
        departureDescriptionLabel.text = Constants.departureDescription
        departureAirportDescriptionLabel.text = Constants.departureAirportDescription
        arrivalDescriptionLabel.text = Constants.arrivalDescription
        arrivalAirportDescriptionLabel.text = Constants.arrivalAirportDescription
        
        companyButton.setTitle(Constants.companyButtonDescription, for: .normal)
        aircraftButton.setTitle(Constants.aircraftButtonDescription, for: .normal)
        
        companyDescriptionLabel.attributes = TextAttributes.averageMediumAttributes
        companyLabel.attributes = TextAttributes.averageMediumAttributes
        departureDescriptionLabel.attributes = TextAttributes.averageMediumAttributes
        departureAirportDescriptionLabel.attributes = TextAttributes.averageMediumAttributes
        departureLabel.attributes = TextAttributes.averageMediumAttributes
        departureAirportLabel.attributes = TextAttributes.averageMediumAttributes
        arrivalDescriptionLabel.attributes = TextAttributes.averageMediumAttributes
        arrivalAirportDescriptionLabel.attributes = TextAttributes.averageMediumAttributes
        arrivalLabel.attributes = TextAttributes.averageMediumAttributes
        arrivalAirportLabel.attributes = TextAttributes.averageMediumAttributes
    }
    

    private enum Constants {
        static let companyDescription: String = "Company"
        static let departureDescription: String = "Departure"
        static let arrivalDescription: String = "Arrival"
        static let departureAirportDescription: String = "Departure Airport"
        static let arrivalAirportDescription: String = "Arrival Airport"
        static let companyButtonDescription: String = "More about this company"
        static let aircraftButtonDescription: String = "More about this aircraft"
    }
}
