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
    var coordinator: Coordinatable?
    var locationManager: CLLocationManager!
//    var viewModel: TravelLocationsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = .zero
        locationManager.desiredAccuracy = .greatestFiniteMagnitude
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        mapView.delegate = self
        title = "Travel Locations Map"

        loadMap()
        
    }
    
    func loadMap() {
        guard let userLocation = locationManager.location?.coordinate else { return }
        let location = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        centerMapOnLocation(location: location)
        setRegion(location: location)
    }
    
    private func centerMapOnLocation(location: CLLocation) {
        let home = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        mapView.setCenter(home, animated: true)
    }
    
    private func setRegion(location: CLLocation) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                 latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }

//    private func setDroppedPin(for studentLocation: StudentLocationRequest, coordinate: CLLocationCoordinate2D) {
//        let annotation = MKPointAnnotation()
//        annotation.title = studentLocation.firstName
//        annotation.subtitle = studentLocation.mediaURL
//        annotation.coordinate = coordinate
//        mapView.addAnnotation(annotation)
//    }
}


extension TravelLocationMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            loadMap()
        }
    }
}
// MARK: MKMapViewDelegate
extension TravelLocationMapViewController: MKMapViewDelegate {
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
//    {
//        if let annotationTitle = view.annotation?.subtitle as? String
//        {
//            guard let url = URL(string: annotationTitle) else { return }
//
//            if UIApplication.shared.canOpenURL(url) {
//                let safariViewController = SFSafariViewController(url: url)
//                present(safariViewController, animated: true)
//            } else {
//                let alert = UIAlertController(title: "Error!", message: "Invalid URL provided", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//                present(alert, animated: true)
//            }
//        }
//    }
}
