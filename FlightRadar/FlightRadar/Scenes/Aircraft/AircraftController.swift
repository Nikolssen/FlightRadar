//
//  AircraftController.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/7/21.
//

import UIKit
import RxCocoa
import RxSwift

class AircraftController: BaseViewController {
    @IBOutlet private var collectionView: UICollectionView!
    
    @IBOutlet private var aircraftRegistrationDescriptionLabel: MonochromeLabel!
    @IBOutlet private var icaoDescriptionLabel: MonochromeLabel!
    @IBOutlet private var enginesDescriptionLabel: MonochromeLabel!
    @IBOutlet private var ageDescriptionLabel: MonochromeLabel!
    @IBOutlet private var firstFlightDescriptionLabel: MonochromeLabel!
    @IBOutlet private var numberOfSeatsDescriptionLabel: MonochromeLabel!
    
    @IBOutlet private var aircraftRegistrationLabel: MonochromeLabel!
    @IBOutlet private var icaoLabel: MonochromeLabel!
    @IBOutlet private var numberOfEnginesLabel: MonochromeLabel!
    @IBOutlet private var ageLabel: MonochromeLabel!
    @IBOutlet private var firstFlightLabel: MonochromeLabel!
    @IBOutlet private var numberOfSeatsLabel: MonochromeLabel!
    
    private var viewModel: AircraftViewModelling!
    private let disposeBag: DisposeBag = .init()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAttributes()
        viewModel.updateRelay
            .bind(onNext: bind)
            .disposed(by: disposeBag)
        
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: Constants.cellID)
        
        viewModel.urlDataSource
            .bind(to: collectionView.rx.items(cellIdentifier: Constants.cellID, cellType: ImageCell.self)) {
                _, url, cell in
                cell.configure(with: url)
            }
            .disposed(by: disposeBag)
    }
    
    private func bind() {
        guard let viewModel = viewModel else { return }
        
        aircraftRegistrationLabel.text = viewModel.registrationNumber
        icaoLabel.text = viewModel.icaoNumber
        numberOfEnginesLabel.text = viewModel.numberOfEngines
        numberOfSeatsLabel.text = viewModel.numberOfSeats
        firstFlightLabel.text = viewModel.firstFlightDate
        ageLabel.text = viewModel.age
    }
    
    private func configureAttributes() {
        
        aircraftRegistrationDescriptionLabel.text = Constants.aircraftRegistrationDescription
        icaoDescriptionLabel.text = Constants.aircraftIcaoDescription
        enginesDescriptionLabel.text = Constants.numberOfEnginesDescription
        ageDescriptionLabel.text = Constants.ageDescription
        firstFlightDescriptionLabel.text = Constants.firstFlightDescription
        numberOfSeatsLabel.text = Constants.numberOfSeatsDescription
        
        aircraftRegistrationDescriptionLabel.attributes = TextAttributes.smallMediumAttributes
        icaoDescriptionLabel.attributes = TextAttributes.smallMediumAttributes
        enginesDescriptionLabel.attributes = TextAttributes.smallMediumAttributes
        ageDescriptionLabel.attributes = TextAttributes.smallMediumAttributes
        firstFlightDescriptionLabel.attributes = TextAttributes.smallMediumAttributes
        numberOfSeatsDescriptionLabel.attributes = TextAttributes.smallMediumAttributes
        
    
        aircraftRegistrationLabel.attributes = TextAttributes.smallMediumAttributes
        icaoLabel.attributes = TextAttributes.smallMediumAttributes
        numberOfEnginesLabel.attributes = TextAttributes.smallMediumAttributes
        ageLabel.attributes = TextAttributes.smallMediumAttributes
        firstFlightLabel.attributes = TextAttributes.smallMediumAttributes
        numberOfSeatsLabel.attributes = TextAttributes.smallMediumAttributes
        
    }
    

    private enum Constants {
        static let aircraftRegistrationDescription: String = "Aircraft registration number"
        static let aircraftIcaoDescription: String = "Aircraft ICAO number"
        static let numberOfEnginesDescription: String = "Number of Engines"
        static let ageDescription: String = "Age"
        static let firstFlightDescription: String = "First flight"
        static let numberOfSeatsDescription: String = "Number of seats"
        
        static let cellID: String = "ImageCellID"
    }
}
