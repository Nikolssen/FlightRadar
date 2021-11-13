//
//  CompanyController.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/7/21.
//

import UIKit
import RxSwift
import RxCocoa
final class CompanyController: BaseViewController {
    @IBOutlet private var titleLabel: MonochromeLabel!
    @IBOutlet private var icaoDescriptionLabel: MonochromeLabel!
    @IBOutlet private var iataDescriptionLabel: MonochromeLabel!
    @IBOutlet private var iataCodeLabel: MonochromeLabel!
    @IBOutlet private var icaoCodeLabel: MonochromeLabel!
    @IBOutlet private var lowcosterLabel: MonochromeLabel!
    @IBOutlet private var pageLabel: MonochromeButton!
    @IBOutlet private var linkButton: MonochromeButton!
    
    var viewModel: CompanyViewModelling!
    private let disposeBag: DisposeBag = .init()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAttributes()
        hideAll()
        viewModel
            .activityIndicatorRelay
            .bind(to: activityIndicatorBinding)
            .disposed(by: disposeBag)
        
        viewModel
            .updateRelay
            .bind(onNext: configure)
            .disposed(by: disposeBag)
        
        linkButton.rx
            .tap
            .bind(to: viewModel.openLinkRelay)
            .disposed(by: disposeBag)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.startRelay.accept(true)
    }
    
    private func hideAll() {
        titleLabel.isHidden = true
        icaoDescriptionLabel.isHidden = true
        iataDescriptionLabel.isHidden = true
        iataCodeLabel.isHidden = true
        icaoCodeLabel.isHidden = true
        lowcosterLabel.isHidden = true
        linkButton.isHidden = true
    }
    
    private func configure() {
        linkButton.isHidden = viewModel.hasLink
        lowcosterLabel.isHidden = !viewModel.isLowcostCarrier
        
        if let name = viewModel.name {
            titleLabel.isHidden = false
            titleLabel.text = name
        }
        
        if let icao = viewModel.icaoCode {
            icaoDescriptionLabel.isHidden = false
            icaoCodeLabel.isHidden = false
            icaoCodeLabel.text = icao
        }
        
        if let iata = viewModel.iataCode {
            iataDescriptionLabel.isHidden = false
            iataCodeLabel.isHidden = false
            iataCodeLabel.text = iata
        }
        
    }
    
    private func configureAttributes() {
        titleLabel.attributes = TextAttributes.largeMediumAttributes
        icaoDescriptionLabel.attributes = TextAttributes.averageMediumAttributes
        iataDescriptionLabel.attributes = TextAttributes.averageMediumAttributes
        iataCodeLabel.attributes = TextAttributes.averageMediumAttributes
        icaoCodeLabel.attributes = TextAttributes.averageMediumAttributes
        lowcosterLabel.attributes = TextAttributes.averageMediumAttributes
        
        icaoDescriptionLabel.text = Constants.icaoDescription
        iataDescriptionLabel.text = Constants.iataDescription
        lowcosterLabel.text = Constants.lowcostDescription
    }

    private enum Constants {
        static let icaoDescription: String = "ICAO Code"
        static let iataDescription: String = "IATA Code"
        static let lowcostDescription: String = "Lowcost carrier"
        static let pageDescription: String = "Official page"
    }
}

