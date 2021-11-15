//
//  MapController.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/1/21.
//

import UIKit
import MapKit
import CoreLocation
import RxSwift
import RxRelay

final class MapController: UIViewController {

    lazy var mapView: MKMapView = {
       let view = MKMapView()
        view.isZoomEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(MKAnnotationView.self, forAnnotationViewWithReuseIdentifier: Constants.mapAnnotationID)
        return view
    }()
    
    lazy var legend: AltitudeLegend = {
        let view = AltitudeLegend()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var viewModel: MapViewModelling!
    
    private var annotation: MKAnnotation?
    private let disposeBag: DisposeBag = .init()
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        view.addSubview(mapView)
        view.addSubview(legend)
        configureLayout()
        
        viewModel
            .flightRelay
            .subscribe(onNext: { [weak self] in
                if let annotation = self?.annotation {
                    self?.mapView.removeAnnotation(annotation)
                }
                guard let value = $0 else { return }
                self?.mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: value.latitude, longitude: value.longitude), latitudinalMeters: 200_000, longitudinalMeters: 200_000)
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: value.latitude, longitude: value.longitude)
                self?.annotation = annotation
                self?.mapView.addAnnotation(annotation)
            })
            .disposed(by: disposeBag)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            legend.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            legend.widthAnchor.constraint(equalToConstant: 20),
            legend.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            legend.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    private enum Constants {
        static let mapAnnotationID: String = "MapID"
    }
}

extension MapController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.mapAnnotationID),
              let liveData = viewModel.flightRelay.value else { return nil }
        annotationView.image = .airplane?
            .withTintColor(AltitudeHeight.color(for: liveData.altitude))
            .imageRotatedByDegrees(degrees: -90 + liveData.direction, flip: false)
        annotationView.annotation = annotation
        return annotationView
    }
}
