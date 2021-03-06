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
    @IBOutlet private var arrivalLabel: MonochromeLabel!
    @IBOutlet private var departureLabel: MonochromeLabel!
    @IBOutlet private var dateLabel: MonochromeLabel!
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var datePicker: UIDatePicker!
    @IBOutlet private var searchButton: MonochromeButton!
    
    var viewModel: TicketsViewModelling!
    let disposeBag: DisposeBag = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        bind()
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellID)
        
        viewModel.dataSourceRelay
            .bind(to: tableView.rx.items(cellIdentifier: Constants.cellID, cellType: TicketCell.self)) {
                _, viewModel, cell in
                cell.configure(with: viewModel)
            }
            .disposed(by: disposeBag)
        
        tableView
            .rx
            .itemSelected
            .map { $0.row }
            .bind(to: viewModel.selectedIndexRelay)
            .disposed(by: disposeBag)
    }
    
    private func bind() {
        viewModel.activityIndicatorRelay
            .bind(to: activityIndicatorBinding)
            .disposed(by: disposeBag)

        datePicker.rx.date
            .bind(to: viewModel.dateSelection)
            .disposed(by: disposeBag)

        arrivalButton.rx
            .tap
            .bind(to: viewModel.arrivalSelectionRelay)
            .disposed(by: disposeBag)
        
        departureButton.rx
            .tap
            .bind(to: viewModel.departureSelectionRelay)
            .disposed(by: disposeBag)
        
        viewModel.arrivalRelay
            .map { $0 ?? " " }
            .bind(to: arrivalLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.departureRelay
            .map { $0 ?? " " }
            .bind(to: departureLabel.rx.text)
            .disposed(by: disposeBag)
        
        searchButton
            .rx
            .tap
            .bind(to: viewModel.searchActionRelay)
            .disposed(by: disposeBag)
        
        viewModel.canSearchRelay
            .map { !$0 }
            .bind(to: searchButton.rx.isHidden)
            .disposed(by: disposeBag)
    }
    
    private func configureUI() {
        titleLabel.attributes = TextAttributes.largeMediumAttributes
        titleLabel.text = Constants.title
        
        arrivalButton.setTitle(Constants.arrival, for: .normal)
        departureButton.setTitle(Constants.departure, for: .normal)
        
        arrivalLabel.attributes = TextAttributes.averageMediumAttributes
        departureLabel.attributes = TextAttributes.averageMediumAttributes
        
        arrivalLabel.text = " "
        departureLabel.text = " "
        
        dateLabel.attributes = TextAttributes.averageMediumAttributes
        dateLabel.text = Constants.date
        
        datePicker.tintColor = .charcoal
        searchButton.setTitle(Constants.search, for: .normal)
        
    }


    
    private enum Constants {
        static let cellID: String = "TicketCellID"
        static let cellNibName: String = "TicketCell"
        static let title: String = "Search for tickets"
        static let arrival: String = "Arrival"
        static let departure: String = "Departure"
        static let date: String = "Date"
        static let search: String = "Search"
    }
}
