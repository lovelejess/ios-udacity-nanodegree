//
//  MainMapViewController.swift
//  OnTheMap
//
//  Created by Jess Le on 2/29/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import UIKit
import MapKit

class MainMapViewController: UIViewController {
    weak var coordinator: MainMapCoordinator?
    @IBOutlet weak var mapView: MKMapView!

    @IBAction func onLogoutPressed(_ sender: Any) {
        coordinator?.navigate(to: .logout)
    }

    @IBAction func onAddButtonPressed(_ sender: Any) {
        coordinator?.navigate(to: .addPin)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        title = "On the Map"
        let location = CLLocation(latitude: 39.742920, longitude: -105.0631619)
        let home = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        centerMapOnLocation(location: location)
        setRegion(location: location)
        setDroppedPin(for: home)
    }

    func centerMapOnLocation(location: CLLocation) {
        let home = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        mapView.setCenter(home, animated: true)
    }
    
    func setRegion(location: CLLocation) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                 latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    func setDroppedPin(for location: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.title = "Jessica Le"
        annotation.subtitle = "https://www.linkedin.com/in/lejessica/"
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
    }
}

extension MainMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    {
        if let annotationTitle = view.annotation?.subtitle as? String
        {
            print("User tapped on annotation with subtitle: \(annotationTitle)")
            if let url = URL(string: annotationTitle) {
                UIApplication.shared.open(url)
            }
        }
    }
}

extension MainMapViewController: MapViewDelegate {
    func reload(with location: CLLocation) {
        centerMapOnLocation(location: location)
        setRegion(location: location)
        let home = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        setDroppedPin(for: home)
    }
}
