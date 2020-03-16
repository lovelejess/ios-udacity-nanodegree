//
//  TabBarCoordinator.swift
//  OnTheMap
//
//  Created by Jess Le on 3/1/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import Foundation
import UIKit

class TabBarCoordinator: Coordinatable {
    var childCoordinators: [Coordinatable] = []
    var rootViewController = UIViewController()
    var parentCoordinator: Coordinatable?
    var window: UIWindow?

    init(window: UIWindow) {
        self.window = window
    }

    /// Responsible for instantiating and pushing views to the stack by relying on further children coordinators
    ///
    /// - Parameters:
    ///     - Destinaton:  A route object with all possible screens
    func navigate(to destination: Destination) {
        switch(destination) {
        case .mainTabBar(.mainMapView):
            let storyboard = UIStoryboard.storyboard(storyboardName: .mainMapView, bundle: Bundle(for: type(of: self)))
            guard let mainTabbarViewController = storyboard.instantiateInitialViewController() as? MainTabbarViewController else {
                fatalError("MainTabbarViewController should always exist")
            }

            mainTabbarViewController.coordinator = self

            let mapCoordinator = MainMapCoordinator(window: window!)
            mapCoordinator.navigate(to: Destination.mainTabBar(.mainMapView))

            childCoordinators.append(mapCoordinator)

            let studentInformationCoordinator = StudentInformationCoordinator(window: window!)
            studentInformationCoordinator.navigate(to: Destination.mainTabBar(.studentInfo))

            childCoordinators.append(studentInformationCoordinator)

            let mapController = mapCoordinator.rootViewController
            let studentInfoController = studentInformationCoordinator.rootViewController
            mainTabbarViewController.viewControllers = [mapController, studentInfoController]

            rootViewController = mainTabbarViewController
        default:
            parentCoordinator?.navigate(to: destination)
        }
    }
}
