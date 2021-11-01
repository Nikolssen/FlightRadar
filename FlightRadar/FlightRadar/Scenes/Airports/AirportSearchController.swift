//
//  AirportSearchController.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/28/21.
//

import UIKit
import RxSwift
import RxCocoa

final class AirportSearchController: UIViewController {
    
    @IBOutlet var searchField: SearchField!
    @IBOutlet var searchButton: MonochromeButton!
    @IBOutlet var collectionView: UICollectionView!
    
    var disposeBag: DisposeBag!
    var viewModel: AirportSearchViewModelling!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
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
        
        collectionView.rx
            .itemSelected
            .map { $0.item }
            .bind(to: viewModel.selectedCellRelay)
            .disposed(by: disposeBag)
        
        viewModel
            .dataSourceRelay
            .bind(to: collectionView.rx.items) {
                collectionView, index, viewModel in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellID, for: IndexPath(item: index, section: 0)) as? AirportCell else { return UICollectionViewCell() }
                cell.configure(with: viewModel)
                return cell
            }
            .disposed(by: disposeBag)
        
        viewModel.activityIndicatorRelay
            .bind(to: activityIndicatorBinding)
            .disposed(by: disposeBag)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    private func configureCollectionView() {
        collectionView.register(AirportCell.self, forCellWithReuseIdentifier: Constants.cellID)
        
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = Constants.lineSpacing
        layout.sectionInset = Constants.sectionInset
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width - Constants.sectionInset.left - Constants.sectionInset.right, height: 160)
    }
    
    private enum Constants {
        static let searchMessage: String = "Search"
        static let searchNearestMessage: String = "Search nearest"
        static let placeholder: String = "City or airport code"
        static let cellID: String = "AirportCell"
        static let lineSpacing: CGFloat = 30.0
        static let sectionInset: UIEdgeInsets = .init(top: 0, left: 20, bottom: 0, right: 20)
    }
}
