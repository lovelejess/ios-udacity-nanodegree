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
    var studentLocations = [StudentInformation]() {
        didSet {
            delegate?.reloadMap()
        }
    }

    init() {
        reloadStudentData()
    }

    func reloadStudentData() {
        UdacityClient.getStudentsLocationByOrder(for: "-updatedAt", completion: self.setStudentsLocation(locations:error:))
    }

    private func setStudentsLocation(locations: [StudentInformation], error: Error?) {
        studentLocations = locations
    }
}
