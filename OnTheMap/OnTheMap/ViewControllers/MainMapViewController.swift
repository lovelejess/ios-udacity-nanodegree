//
//  MainMapViewController.swift
//  OnTheMap
//
//  Created by Jess Le on 2/29/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MainMapViewController: UIViewController {
    weak var coordinator: MainMapCoordinator?
    @IBOutlet weak var mapView: MKMapView!

    var viewModel: MapViewModel?

    @IBAction func onLogoutPressed(_ sender: Any) {
        coordinator?.navigate(to: .logout)
    }

    @IBAction func onAddButtonPressed(_ sender: Any) {
        coordinator?.navigate(to: .addPin)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        viewModel?.delegate = self
        title = "On the Map"
        reloadMap()
    }

    override func viewDidAppear(_ animated: Bool) {
        reloadMap()
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

    private func setDroppedPin(for studentLocation: Student, coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.title = studentLocation.firstName
        annotation.subtitle = studentLocation.mediaURL
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
}

// MARK: MKMapViewDelegate
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

// MARK: MapViewModelDelegate
extension MainMapViewController: MapViewModelDelegate {
    func reloadMap() {
        guard let studentLocation = viewModel?.studentLocations.first else { return }
        let location = CLLocation(latitude: studentLocation.latitude, longitude: studentLocation.longitude)
        let locationCoordinate2D = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        centerMapOnLocation(location: location)
        setRegion(location: location)
        setDroppedPin(for: studentLocation, coordinate: locationCoordinate2D)
    }
}

//// MARK: InformationPostingDelegate
//extension MainMapViewController: InformationPostingDelegate {
//    func refreshStudentLocations() {
//        UdacityClient.getStudentsLocationByUniqueKey(for: "CDHfAy8sdp")  { (newStudentLocations, error) in
//            let sortedLocations = newStudentLocations.sorted {
//                $0.updatedAt > $1.updatedAt
//            }
//            self.viewModel?.studentLocations = sortedLocations
//        }
//    }
//}
