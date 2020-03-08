//
//  StudentLocationRequest.swift
//  OnTheMap
//
//  Created by Jess Le on 3/8/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import Foundation

struct StudentLocationRequest: Codable {
    let uniqueKey: String
    var firstName: String
    var lastName: String
    var mapString: String
    var mediaURL: String
    var longitude: Double
    var latitude: Double
}
