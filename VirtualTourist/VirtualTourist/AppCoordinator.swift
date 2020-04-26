//
//  AppCoordinator.swift
//  VirtualTourist
//
//  Created by Jess Le on 4/24/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: Coordinatable {

    var window: UIWindow!
    var rootViewController: UIViewController?
    var childControllers: [UIViewController]?
    var parentCoordinator: Coordinatable?

    init(window: UIWindow) {
        self.window = window
    }

    func navigate(to route: Route) {
        switch route {
        case .travelLocationsMap:
            let storyboard = UIStoryboard.storyboard(storyboardName: .travelLocationsMap, bundle: Bundle(for: type(of: self)))
            let navigationController = storyboard.viewController(for: .travelLocationMapNavigation) as UINavigationController
            let viewController = storyboard.viewController(for: .travelLocationMapViewController) as TravelLocationMapViewController
            navigationController.viewControllers = [viewController]
            viewController.coordinator = self
            rootViewController = navigationController
            window.rootViewController = navigationController
        }
    }
}
