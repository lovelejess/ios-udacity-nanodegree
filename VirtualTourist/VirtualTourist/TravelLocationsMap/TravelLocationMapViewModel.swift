//
//  TravelLocationMapViewModel.swift
//  VirtualTourist
//
//  Created by Jess Le on 4/26/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import Foundation
import MapKit
import CoreData

class TravelLocationViewModel: NSObject {

    var userPreferences: UserPreferences!
    var coordinator: Coordinatable!
    var locationManager: CLLocationManager!
    var dataController: DataController!

    var delegate: TravelLocationsMapDelegate?

    // The NSFetchedResultsController
    var fetchResultsController: NSFetchedResultsController<Pin>!

    init(coordinator: Coordinatable, userPreferences: UserPreferences = UserPreferences(), dataController: DataController) {
        super.init()
        self.coordinator = coordinator
        self.userPreferences = userPreferences
        self.dataController = dataController

        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = .zero
        locationManager.desiredAccuracy = .greatestFiniteMagnitude
        locationManager.startUpdatingLocation()

        createFetchResultsController()

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

    func addDroppedPin(for location: Location) {
        let pin =  Pin(context: dataController.viewContext)
        pin.creationDate = Date()
        pin.latitude = location.latitude
        pin.longitude = location.longitude

        let backgroundContext = dataController.backgroundContext
        backgroundContext?.perform {
            try? self.dataController.viewContext.save()
        }
    }

    func loadDroppedPins() -> [Pin] {
        let fetchRequest: NSFetchRequest<Pin> = Pin.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]

        var pins: [Pin] = []
        do {
            pins = try dataController.viewContext.fetch(fetchRequest)
        } catch (let error) {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
        return pins
    }

    func createFetchResultsController() {
        let fetchRequest: NSFetchRequest<Pin> = Pin.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]

        fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: "pins")
        fetchResultsController.delegate = self
        do {
            try fetchResultsController.performFetch()
        } catch (let error) {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
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

extension TravelLocationViewModel: NSFetchedResultsControllerDelegate {
}
