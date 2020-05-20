//
//  TravelLocationMapCoordinator.swift
//  VirtualTourist
//
//  Created by Jess Le on 4/24/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import Foundation
import UIKit
import MapKit

protocol Coordinatable: class {
    var rootViewController: UIViewController! { get }
    var childControllers: [UIViewController]? { get set }
    var parentCoordinator: Coordinatable? { get set }
    var userPreferences: UserPreferences! { get set }
    func navigate(to route: Route)
}

enum Route {
    case travelLocationsMap
    case photoAlbum(location: CLLocationCoordinate2D)
}

