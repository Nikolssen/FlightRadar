//
//  AircraftController.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/7/21.
//

import UIKit
import RxCocoa
import RxSwift

final class AircraftController: BaseViewController {
    @IBOutlet private var titleLabel: MonochromeLabel!
    @IBOutlet private var collectionView: UICollectionView!
    
    @IBOutlet private var aircraftRegistrationDescriptionLabel: MonochromeLabel!
    @IBOutlet private var ownerDescriptionLabel: MonochromeLabel!
    @IBOutlet private var enginesDescriptionLabel: MonochromeLabel!
    @IBOutlet private var ageDescriptionLabel: MonochromeLabel!
    @IBOutlet private var firstFlightDescriptionLabel: MonochromeLabel!

    @IBOutlet private var aircraftRegistrationLabel: MonochromeLabel!
    @IBOutlet private var ownerLabel: MonochromeLabel!
    @IBOutlet private var numberOfEnginesLabel: MonochromeLabel!
    @IBOutlet private var ageLabel: MonochromeLabel!
    @IBOutlet private var firstFlightLabel: MonochromeLabel!
    
    var viewModel: AircraftViewModelling!
    
    private let disposeBag: DisposeBag = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAttributes()
        hideAll()
        
        viewModel.updateRelay
            .bind(onNext: configure)
            .disposed(by: disposeBag)
        
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: Constants.cellID)
        
        viewModel.urlDataSource
            .filter{ !$0.isEmpty }
            .subscribe(onNext: { [weak self] _ in self?.collectionView.isHidden = false })
            .disposed(by: disposeBag)
        
        viewModel.urlDataSource
            .bind(to: collectionView.rx.items(cellIdentifier: Constants.cellID, cellType: ImageCell.self)) {
                _, url, cell in
                cell.configure(with: url)
            }
            .disposed(by: disposeBag)
        
        viewModel.activityIndicatorRelay
            .bind(to: activityIndicatorBinding)
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.startRelay.accept(true)
    }
    
    private func configure() {
        guard let viewModel = viewModel else { return }
        if let registrationNumber = viewModel.registrationNumber {
            aircraftRegistrationLabel.text = registrationNumber
            aircraftRegistrationLabel.isHidden = false
            aircraftRegistrationDescriptionLabel.isHidden = false
        }
        
        if let icaoNumber = viewModel.owner{
            ownerLabel.text = icaoNumber
            ownerDescriptionLabel.isHidden = false
            ownerLabel.isHidden = false
        }

        
        if let numberOfEngines = viewModel.numberOfEngines{
            numberOfEnginesLabel.text = numberOfEngines
            enginesDescriptionLabel.isHidden = false
            numberOfEnginesLabel.isHidden = false
        }
        
        if let firstFlight = viewModel.firstFlightDate{
            firstFlightLabel.text = firstFlight
            firstFlightLabel.isHidden = false
            firstFlightDescriptionLabel.isHidden = false
        }
        
        
        if let age = viewModel.age{
            ageLabel.text = age
            ageLabel.isHidden = false
            ageDescriptionLabel.isHidden = false
        }

        if let title = viewModel.title {
            titleLabel.text = title
            titleLabel.isHidden = false
        }
        
    }
    
    private func hideAll() {
        titleLabel.isHidden = true
        collectionView.isHidden = true
        aircraftRegistrationDescriptionLabel.isHidden = true
        ownerDescriptionLabel.isHidden = true
        enginesDescriptionLabel.isHidden = true
        ageDescriptionLabel.isHidden = true
        firstFlightDescriptionLabel.isHidden = true

        aircraftRegistrationLabel.isHidden = true
        ownerLabel.isHidden = true
        numberOfEnginesLabel.isHidden = true
        ageLabel.isHidden = true
        firstFlightLabel.isHidden = true
    }
    
    private func configureAttributes() {
        titleLabel.attributes = TextAttributes.largeMediumAttributes
        aircraftRegistrationDescriptionLabel.text = Constants.aircraftRegistrationDescription
        ownerDescriptionLabel.text = Constants.ownerDescription
        enginesDescriptionLabel.text = Constants.numberOfEnginesDescription
        ageDescriptionLabel.text = Constants.ageDescription
        firstFlightDescriptionLabel.text = Constants.firstFlightDescription
        
        aircraftRegistrationDescriptionLabel.attributes = TextAttributes.averageMediumAttributes
        ownerDescriptionLabel.attributes = TextAttributes.averageMediumAttributes
        enginesDescriptionLabel.attributes = TextAttributes.averageMediumAttributes
        ageDescriptionLabel.attributes = TextAttributes.averageMediumAttributes
        firstFlightDescriptionLabel.attributes = TextAttributes.averageMediumAttributes

        
    
        aircraftRegistrationLabel.attributes = TextAttributes.averageMediumAttributes
        ownerLabel.attributes = TextAttributes.averageMediumAttributes
        numberOfEnginesLabel.attributes = TextAttributes.averageMediumAttributes
        ageLabel.attributes = TextAttributes.averageMediumAttributes
        firstFlightLabel.attributes = TextAttributes.averageMediumAttributes
        
    }
    

    private enum Constants {
        static let aircraftRegistrationDescription: String = "Aircraft registration number"
        static let ownerDescription: String = "Owner"
        static let numberOfEnginesDescription: String = "Number of Engines"
        static let ageDescription: String = "Age"
        static let firstFlightDescription: String = "First flight"
        
        static let cellID: String = "ImageCellID"
    }
}
