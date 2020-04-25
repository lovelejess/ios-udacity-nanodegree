//
//  TravelLocationMapViewController.swift
//  VirtualTourist
//
//  Created by Jess Le on 4/21/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import UIKit
import MapKit

class TravelLocationMapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    var coordinator: Coordinatable?

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        title = "Travel Locations Map"
    }

}

// MARK: MKMapViewDelegate
extension TravelLocationMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    {
    }
}
