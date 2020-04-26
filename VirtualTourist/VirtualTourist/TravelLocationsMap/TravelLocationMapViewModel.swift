//
//  TravelLocationMapViewModel.swift
//  VirtualTourist
//
//  Created by Jess Le on 4/26/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import Foundation
import MapKit

class TravelLocationViewModel: NSObject {

    var userPreferences: UserPreferences!
    var coordinator: Coordinatable!
    var locationManager: CLLocationManager!

    var delegate: TravelLocationsMapDelegate?

    init(coordinator: Coordinatable, userPreferences: UserPreferences = UserPreferences()) {
        super.init()
        self.coordinator = coordinator
        self.userPreferences = userPreferences

        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = .zero
        locationManager.desiredAccuracy = .greatestFiniteMagnitude
        locationManager.startUpdatingLocation()
    }
    
    func setLocation(for newLocation: CLLocationCoordinate2D) {
        userPreferences.location = Location(latitude: newLocation.latitude, longitude: newLocation.longitude)
    }

    func getLocation() -> Location? {
        return userPreferences.location
    }

    func getCurrentUserLocation() -> Location? {
        guard let userLocation = locationManager.location?.coordinate else {
            return nil
        }
        return Location(latitude: userLocation.latitude, longitude: userLocation.longitude)
    }
}

extension TravelLocationViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            guard let userLocation: Location = getLocation() ?? getCurrentUserLocation() else { return }
            let location = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
            delegate?.loadMap(for: location)
        }
    }
}

protocol TravelLocationsMapDelegate: class {
    func loadMap(for location: CLLocation)
}
