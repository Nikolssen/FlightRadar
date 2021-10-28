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
    
    @IBOutlet var serchField: SearchField!
    @IBOutlet var searchButton: MonochromeButton!
    @IBOutlet var collectionView: UICollectionView!
    
    var disposeBag: DisposeBag!
    var viewModel: AirportSearchViewModelling!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
}
