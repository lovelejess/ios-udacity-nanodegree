//
//  Breed.swift
//  Randog
//
//  Created by Jess Le on 2/16/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import Foundation

struct BreedResponse: Codable {
    let message: [String: [String]]
    let status: String
}

struct Subtype: Codable {
    let type: String
}

struct Breed: Codable {
    let type: String
    let subtype: [Subtype]
}
