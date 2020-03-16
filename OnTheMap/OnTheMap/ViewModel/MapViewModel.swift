//
//  MapViewModel.swift
//  OnTheMap
//
//  Created by Jess Le on 3/8/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class MapViewModel {
    var delegate: MapViewModelDelegate?
    var studentLocations = [Student]() {
        didSet {
            delegate?.reloadMap()
        }
    }

    init() {
        UdacityClient.getStudentsLocationByOrder(for: "-updatedAt", completion: self.setStudentsLocation(locations:error:))
    }

    private func setStudentsLocation(locations: [Student], error: Error?) {
        studentLocations = locations
    }
}

protocol MapViewModelDelegate {
    func reloadMap()
}
