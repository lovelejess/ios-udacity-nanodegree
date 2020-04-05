//
//  StudentInformation.swift
//  OnTheMap
//
//  Created by Jess Le on 3/8/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import Foundation

struct Students: Codable {
    let results: [StudentInformation]
}

struct StudentInformation: Codable {
    let createdAt: String
    let firstName: String
    let lastName: String
    let latitude: Double
    let longitude: Double
    let mapString: String
    let mediaURL: String
    let objectId: String
    let uniqueKey: String
    let updatedAt: String
}
