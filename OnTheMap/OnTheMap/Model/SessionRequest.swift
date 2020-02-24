//
//  SessionRequest.swift
//  OnTheMap
//
//  Created by Jess Le on 2/23/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import Foundation

struct SessionRequest: Codable {
    let udacity: Credentials
}

struct Credentials: Codable {
    let username: String
    let password: String
}
