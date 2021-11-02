//
//  AirportDetailsController.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/1/21.
//

import UIKit
import MapKit

final class AirportDetailsController: UIViewController {

    @IBOutlet private var airportView: UIView!
    var viewModel: AirportDetailsViewModelling!
    @IBOutlet private var optionsCollectionView: UICollectionView!
    @IBOutlet private var flightsCollectionView: UICollectionView!
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
