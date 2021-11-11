//
//  TicketsController.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/7/21.
//

import UIKit
import RxSwift
import RxCocoa

final class TicketsController: UIViewController {

    @IBOutlet private var titleLabel: MonochromeLabel!
    @IBOutlet private var arrivalButton: MonochromeButton!
    @IBOutlet private var departureButton: MonochromeButton!
    @IBOutlet private var dateButton: MonochromeButton!
    @IBOutlet private var arrivalLabel: MonochromeLabel!
    @IBOutlet private var departureLabel: MonochromeLabel!
    @IBOutlet private var dateLabel: MonochromeLabel!
    @IBOutlet private var tableView: UITableView!
    
    var viewModel: TicketsViewModelling!
    let disposeBag: DisposeBag = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.activityIndicatorRelay
            .bind(to: activityIndicatorBinding)
            .disposed(by: disposeBag)
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellID)
    }
    
    private func configureUI() {
        titleLabel.attributes = TextAttributes.largeMediumAttributes
        titleLabel.text = Constants.title
    }


    
    private enum Constants {
        static let cellID: String = "TicketCellID"
        static let cellNibName: String = "TicketCell"
        static let title: String = "Search for tickets"
    }
}
