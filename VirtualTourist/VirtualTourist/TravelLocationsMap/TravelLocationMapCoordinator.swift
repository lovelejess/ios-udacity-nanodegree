//
//  TravelLocationMapCoordinator.swift
//  VirtualTourist
//
//  Created by Jess Le on 4/24/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinatable: class {
    var rootViewController: UIViewController? { get set }
    var childControllers: [UIViewController]? { get set }
    var parentCoordinator: Coordinatable? { get set }
    var userPreferences: UserPreferences! { get set }
    func navigate(to route: Route)
}

enum Route {
    case travelLocationsMap
}

class TravelLocationMapCoordinator: Coordinatable {

    var rootViewController: UIViewController?
    var childControllers: [UIViewController]?
    var parentCoordinator: Coordinatable?
    var userPreferences: UserPreferences!
    
    func navigate(to route: Route) {
        
    }
    
    
}
