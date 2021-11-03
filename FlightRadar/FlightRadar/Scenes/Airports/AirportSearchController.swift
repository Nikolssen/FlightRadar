//
//  AirportSearchController.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/28/21.
//

import UIKit
import RxSwift
import RxCocoa

final class AirportSearchController: UIViewController, UITableViewDelegate {
    
    @IBOutlet var searchField: SearchField!
    @IBOutlet var searchButton: MonochromeButton!

    @IBOutlet var tableView: UITableView!
    
    var disposeBag: DisposeBag!
    var viewModel: AirportSearchViewModelling!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureSearchField()
        bind()
    }
    
    private func configureSearchField() {
        searchField.placeholder = Constants.placeholder
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
    }
    
    private func bind() {
        self.disposeBag = DisposeBag()
        
        let textObservable =
        searchField.rx
            .text
            .orEmpty
            .share()
        
        textObservable
            .map { $0.isEmpty ? Constants.searchNearestMessage : Constants.searchMessage }
            .subscribe(onNext: {[weak self] in self?.searchButton.setTitle($0, for: .normal) })
            .disposed(by: disposeBag)
        
        textObservable
            .bind(to: viewModel.searchTextRelay)
            .disposed(by: disposeBag)
        
        searchButton.rx
            .tap
            .bind(to: viewModel.searchActionRelay)
            .disposed(by: disposeBag)
        
        tableView.rx
            .itemHighlighted
            .debug()
            .map { $0.item }
            .debug()
            .bind(to: viewModel.selectedCellRelay)
            .disposed(by: disposeBag)
        
        viewModel
            .dataSourceRelay
            .bind(to: tableView.rx.items) {
                tableView, index, viewModel in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellID, for: IndexPath(item: index, section: 0)) as? AirportCell else { return UITableViewCell() }
                cell.configure(with: viewModel)
                return cell
            }
            .disposed(by: disposeBag)
        
        viewModel.activityIndicatorRelay
            .bind(to: activityIndicatorBinding)
            .disposed(by: disposeBag)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    private func configureTableView() {
        tableView.register(AirportCell.self, forCellReuseIdentifier: Constants.cellID)
        tableView.separatorColor = .clear
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.allowsSelection = true
    }
    
    private enum Constants {
        static let searchMessage: String = "Search"
        static let searchNearestMessage: String = "Search nearest"
        static let placeholder: String = "City or airport code"
        static let cellID: String = "AirportCell"
        static let lineSpacing: CGFloat = 30.0
    }
}
