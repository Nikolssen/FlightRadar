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

final class AirportDetailsController: BaseViewController {
    @IBOutlet private var favoriteButton: UIButton!
    
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
        mapView.register(MKAnnotationView.self, forAnnotationViewWithReuseIdentifier: Constants.mapAnotationID)
        NSLayoutConstraint.activate([
            mapView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mapView.topAnchor.constraint(equalTo: optionsCollectionView.bottomAnchor, constant: 20),
            mapView.heightAnchor.constraint(equalTo: mapView.widthAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
        ])
        isMapLoaded = true
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionViews()
        favoriteButton.isHidden = true
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
            .bind(to: optionsCollectionView.rx.items(cellIdentifier: Constants.optionsID, cellType: OptionCell.self)) {
                _, text, cell in
                cell.label.text = text
            }
            .disposed(by: disposeBag)
        
        viewModel
            .mapPointRelay
            .compactMap { $0 }
            .subscribe(onNext: {[weak self] in self?.mapView.region = MKCoordinateRegion(center: $0, latitudinalMeters: 100_000, longitudinalMeters: 100_00)
                self?.mapView.delegate = self
                let annotation = MKPointAnnotation()
                annotation.coordinate = $0
                self?.mapView.addAnnotations([annotation])
                
            })
            .disposed(by: disposeBag)
        
        let selectedIndexObservable =
        optionsCollectionView
            .rx
            .itemSelected
            .map { $0.item }
        
        selectedIndexObservable
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                switch $0 {
                case 0:
                    if self.isMapLoaded  {
                        self.flightsCollectionView.isHidden = true
                        self.mapView.isHidden = false
                    }
                    else {
                        fallthrough
                    }
                default:
                    if self.isMapLoaded  {
                        self.mapView.isHidden = true
                    }
                    self.flightsCollectionView.isHidden = false
                }
            })
            .disposed(by: disposeBag)
        
        selectedIndexObservable
            .bind(to: viewModel.selectedOptionRelay)
            .disposed(by: disposeBag)
        
        viewModel
            .dataSourceRelay
            .bind(to: flightsCollectionView.rx.items(cellIdentifier: Constants.flightsID, cellType: FlightCell.self)) {
                _, viewModel, cell in
                cell.configure(with: viewModel)
            }
            .disposed(by: disposeBag)
        
        flightsCollectionView.rx
            .itemSelected
            .map { $0.item }
            .bind(to: viewModel.selectedFlightRelay)
            .disposed(by: disposeBag)
        
        viewModel.activityIndicatorRelay
            .bind(to: activityIndicatorBinding)
            .disposed(by: disposeBag)
        
        viewModel
            .isFavoriteRelay
            .compactMap{ $0 }
            .subscribe(onNext: { [favoriteButton] in
                favoriteButton?.isHidden = false
                favoriteButton?.setImage($0 ? .filledStar : .star, for: .normal)
            })
            .disposed(by: disposeBag)
        
        favoriteButton.rx
            .tap
            .bind(to: viewModel.favoriteActionRelay)
            .disposed(by: disposeBag)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if isMapLoaded {
            mapView.layer.borderColor = UIColor.charcoal.cgColor
        }
    }
    
    private func configureCollectionViews() {
        optionsCollectionView.register(OptionCell.self, forCellWithReuseIdentifier: Constants.optionsID)
        flightsCollectionView.register(FlightCell.self, forCellWithReuseIdentifier: Constants.flightsID)
        optionsCollectionView.showsHorizontalScrollIndicator = false
        optionsCollectionView.delegate = self
        flightsCollectionView.delegate = self
        optionsCollectionView.allowsSelection = true
        flightsCollectionView.allowsSelection = true
        optionsCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: [])
    }
    
    
    private enum Constants {
        static let map: String = "Map"
        static let departures: String = "Departures"
        static let arrivals: String = "Arrivals"
        static let optionsID: String = "OptionsID"
        static let flightsID: String = "FlightsID"
        static let mapAnotationID: String = "MapID"
    }
    
}

extension AirportDetailsController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.mapAnotationID)
        annotationView?.image = .airport
        annotationView?.annotation = annotation
        return annotationView
    }
}

extension AirportDetailsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView === optionsCollectionView {
            let text = isMapLoaded ? [Constants.map, Constants.departures, Constants.arrivals][indexPath.item] : [Constants.departures, Constants.arrivals][indexPath.item]
            return OptionCell.size(for: text)
        }
        
        else {
            return FlightCell.Constants.size
        }
    }
}
