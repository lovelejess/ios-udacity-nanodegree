//
//  TravelLocationMapViewController.swift
//  VirtualTourist
//
//  Created by Jess Le on 4/21/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class TravelLocationMapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var viewModel: TravelLocationViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        mapView.showsUserLocation = true
        mapView.delegate = self
        title = "Travel Locations Map"

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapMap(gestureRecognizer:)))
        self.view.addGestureRecognizer(gestureRecognizer)
    }

    @objc func didTapMap(gestureRecognizer : UITapGestureRecognizer ) {
        guard gestureRecognizer.view != nil else { return }
        guard gestureRecognizer.state == UIGestureRecognizer.State.ended else { return }
        let touchLocation = gestureRecognizer.location(in: mapView)
        let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
        print("Tapped at lat: \(locationCoordinate.latitude) long: \(locationCoordinate.longitude)")
        setDroppedPin(for: locationCoordinate)
    }
    
    private func centerMapOnLocation(location: CLLocation) {
        let home = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        mapView.setCenter(home, animated: true)
    }
    
    private func setRegion(location: CLLocation) {
        let regionRadius: CLLocationDistance = 2000
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                 latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    private func setDroppedPin(for coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
}

// MARK: TravelLocationsMapDelegate
extension TravelLocationMapViewController: TravelLocationsMapDelegate {
    func loadMap(for location: CLLocation) {
        centerMapOnLocation(location: location)
        setRegion(location: location)
    }
}


// MARK: MKMapViewDelegate
extension TravelLocationMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    {
        if let location = view.annotation?.coordinate {
            viewModel.setLocation(for: location)
        }
    }
}
