//
//  Location.swift
//  VirtualTourist
//
//  Created by Jess Le on 4/25/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import Foundation
import MapKit

struct Location: Codable, Hashable {
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
}
