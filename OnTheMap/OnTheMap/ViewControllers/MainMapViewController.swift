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
import SafariServices

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

    @IBAction func onRefreshButtonPressed(_ sender: Any) {
        viewModel?.reloadStudentData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        viewModel?.delegate = self
        viewModel?.reloadStudentData()
        title = "On the Map"
    }

    override func viewDidAppear(_ animated: Bool) {
        viewModel?.reloadStudentData()
    }

    private func setDroppedPin(for studentLocation: StudentInformation, coordinate: CLLocationCoordinate2D) {
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
            guard let url = URL(string: annotationTitle) else { return }

            if UIApplication.shared.canOpenURL(url) {
                let safariViewController = SFSafariViewController(url: url)
                present(safariViewController, animated: true)
            } else {
                let alert = UIAlertController(title: "Error!", message: "Invalid URL provided", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                present(alert, animated: true)
            }
        }
    }
}

// MARK: MapViewModelDelegate
extension MainMapViewController: MapViewModelDelegate {
    func reloadMap() {
        guard let studentLocations = viewModel?.studentLocations else {
            let alert = UIAlertController(title: "Error", message: "Unable to retrieve students locations. Please refresh and try again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
        }

        for studentLocation in studentLocations {
            let location = CLLocation(latitude: studentLocation.latitude, longitude: studentLocation.longitude)
            let locationCoordinate2D = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            setDroppedPin(for: studentLocation, coordinate: locationCoordinate2D)
        }
    }
}
