//
//  InformationLocationViewController.swift
//  OnTheMap
//
//  Created by Jess Le on 3/14/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import UIKit
import MapKit
import SafariServices

class InformationLocationViewController: UIViewController {
    weak var coordinator: Coordinatable?
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var submitButton: UIButton!

    var viewModel: InformationPostingViewModel?

    @IBAction func onSubmitButtonPressed(_ sender: Any) {
        self.dismiss(animated: true) {
            self.coordinator?.navigate(to: .root)
            self.viewModel?.postStudentLocation {
                let alert = UIAlertController(title: "Error", message: "Unable to post new location. Please try again", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true)
                return
            }
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        viewModel?.delegate = self
        submitButton.layer.cornerRadius = 4
        loadMap()
        
    }
    
    func loadMap() {
        guard let studentLocationRequest = viewModel?.studentLocationRequest else {
            let alert = UIAlertController(title: "Error", message: "Unable to retrieve students locations. Please refresh and try again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
        }
        let location = CLLocation(latitude: studentLocationRequest.latitude, longitude: studentLocationRequest.longitude)
        let locationCoordinate2D = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        centerMapOnLocation(location: location)
        setRegion(location: location)
        setDroppedPin(for: studentLocationRequest, coordinate: locationCoordinate2D)
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

    private func setDroppedPin(for studentLocation: StudentLocationRequest, coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.title = studentLocation.firstName
        annotation.subtitle = studentLocation.mediaURL
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
}

// MARK: MKMapViewDelegate
extension InformationLocationViewController: MKMapViewDelegate {
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

extension InformationLocationViewController: InformationPostingDelegate {
    func refreshStudentLocations() {
        loadMap()
    }
}
