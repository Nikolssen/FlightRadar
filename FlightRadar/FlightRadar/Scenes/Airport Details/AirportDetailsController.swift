//
//  AirportDetailsController.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/1/21.
//

import UIKit
import MapKit
import RxSwift
import RxCocoa

final class AirportDetailsController: UIViewController {

    @IBOutlet private var airportView: AirportView!
    var viewModel: AirportDetailsViewModelling!
    @IBOutlet private var optionsCollectionView: UICollectionView!
    @IBOutlet private var flightsCollectionView: UICollectionView!
    private var disposeBag: DisposeBag!
    
    private var isMapLoaded: Bool = false
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        mapView.layer.cornerRadius = 20
        mapView.layer.borderWidth = 1
        mapView.layer.borderColor = UIColor.charcoal.cgColor
        mapView.layer.cornerCurve = .continuous
        mapView.isZoomEnabled = false
        NSLayoutConstraint.activate([
            mapView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mapView.topAnchor.constraint(equalTo: optionsCollectionView.topAnchor, constant: 20),
            mapView.heightAnchor.constraint(equalTo: mapView.widthAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
        ])
        isMapLoaded = true
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionViews()
        bind()
    }
    
    private func bind() {
        self.disposeBag = DisposeBag()
        
        viewModel.airportInfoRelay
            .subscribe(onNext: { [weak self] in
                self?.airportView.configure(with: $0)
            })
            .disposed(by: disposeBag)
        
        viewModel
            .mapPointRelay
            .map {
                $0 != nil ? [Constants.map, Constants.departures, Constants.arrivals] : [Constants.departures, Constants.arrivals]
            }
            .bind(to: optionsCollectionView.rx.items(cellIdentifier: Constants.optionsID)) {
                _, text, cell in
                (cell as? OptionCell)?.label.text = text
            }
            .disposed(by: disposeBag)
        
        viewModel
            .mapPointRelay
            .compactMap { $0 }
            .subscribe(onNext: {[weak self] in self?.mapView.region = MKCoordinateRegion(center: $0, latitudinalMeters: 100_000, longitudinalMeters: 100_00)
                let annotation = MKPointAnnotation()
                annotation.coordinate = $0
                
                self?.mapView.addAnnotations([])
                
            })
            .disposed(by: disposeBag)
        
    }
    
    private func configureCollectionViews() {
        optionsCollectionView.register(UINib(nibName: "OptionCell", bundle: nil), forCellWithReuseIdentifier: Constants.optionsID)
        flightsCollectionView.register(FlightCell.self, forCellWithReuseIdentifier: Constants.flightsID)
        
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private enum Constants {
        static let map: String = "Map"
        static let departures: String = "Departures"
        static let arrivals: String = "Arrivals"
        static let optionsID: String = "OptionsID"
        static let flightsID: String = "FlightsID"
    }
    
}
