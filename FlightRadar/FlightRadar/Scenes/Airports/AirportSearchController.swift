//
//  AirportSearchController.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/28/21.
//

import UIKit
import RxSwift
import RxCocoa

class AirportSearchController: UIViewController {
    
    @IBOutlet var searchField: SearchField!
    @IBOutlet var searchButton: MonochromeButton!
    @IBOutlet var collectionView: UICollectionView!
    
    var disposeBag: DisposeBag!
    var viewModel: AirportSearchViewModelling!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchField.placeholder = Constants.placeholder
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    
    
    private enum Constants {
        static let searchMessage: String = "Search"
        static let searchNearestMessage: String = "Search nearest"
        static let placeholder: String = "City or airport code"
    }
}
