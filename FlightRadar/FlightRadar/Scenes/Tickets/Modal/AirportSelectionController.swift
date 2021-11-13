//
//  AirportSelectionController.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/12/21.
//

import UIKit
import RxSwift
import RxCocoa

final class AirportSelectionController: UIViewController {
    @IBOutlet private var dismissalView: UIView!
    @IBOutlet private var tableView: UITableView!
    
    private let disposeBag: DisposeBag = .init()
    
    var viewModel: AirportSelectionViewModelling!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDismissal()
        configureTableView()
        
    }
    
    private func configureDismissal() {
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(dismissAction))
        gesture.direction = .down
        dismissalView.addGestureRecognizer(gesture)
    }
    
    private func configureTableView() {
        tableView.register(AirportCell.self, forCellReuseIdentifier: Constants.cellID)
        
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        viewModel
            .dataSourceRelay
            .bind(to: tableView.rx.items) {
                tableView, index, viewModel in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellID, for: IndexPath(item: index, section: 0)) as? AirportCell else { return UITableViewCell() }
                cell.configure(with: viewModel)
                return cell
            }
            .disposed(by: disposeBag)
        
        tableView
            .rx
            .itemSelected
            .map { $0.row }
            .bind(to: viewModel.selectedIndexRelay)
            .disposed(by: disposeBag)
    }
    
    @objc private func dismissAction() {
        viewModel.dismissalRelay.accept(Void())
    }
    
    private enum Constants {
        static let cellID: String = "AirportCellID"
    }
}
