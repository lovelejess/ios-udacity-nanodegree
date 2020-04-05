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

    weak var delegate: InformationPostingDelegate?

    var studentLocationRequest: StudentLocationRequest? {
        didSet {
            delegate?.refreshStudentLocations()
        }
    }
    typealias Handler = () -> Void
    func postStudentLocation(completion: Handler?) {
        guard let request = self.studentLocationRequest else { return }
        UdacityClient.postStudentsLocation(body: request) { (response, error) in
            if error != nil {
                guard let completion = completion else { return }
                completion()
            }
        }
    }

    func getCoordinateFrom(mapString: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        CLGeocoder().geocodeAddressString(mapString) { completion($0?.first?.location?.coordinate, $1) }
    }
}
