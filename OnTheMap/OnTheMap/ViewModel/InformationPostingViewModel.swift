//
//  InformationPostingViewModel.swift
//  OnTheMap
//
//  Created by Jess Le on 3/14/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import Foundation
import CoreLocation

class InformationPostingViewModel {
    weak var delegate: InformationLocationViewDelegate?

    var studentLocationRequest: StudentLocationRequest? {
        didSet {
            delegate?.reloadMap()
        }
    }

    func postStudentLocation() {
        guard let request = self.studentLocationRequest else { return }
        UdacityClient.postStudentsLocation(body: request) { (response, error) in
            if error == nil {
                fatalError("oops unable to post student locations")
            }
        }
    }

    func createStudentLocationRequest(uniqueKey: String, firstName: String, lastName: String, mapString: String, mediaURL: String) {
        getCoordinateFrom(mapString: mapString) { coordinate, error in
            guard let coordinate = coordinate else { print("unable to get coordinate \(String(describing: error))"); return }
            self.studentLocationRequest = StudentLocationRequest(uniqueKey: uniqueKey, firstName: firstName, lastName: lastName, mapString: mapString, mediaURL: mediaURL, longitude: coordinate.longitude, latitude: coordinate.latitude)
        }
    }

    func getCoordinateFrom(mapString: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        CLGeocoder().geocodeAddressString(mapString) { completion($0?.first?.location?.coordinate, $1) }
    }
}
