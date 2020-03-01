//
//  MainMapCoordinator.swift
//  OnTheMap
//
//  Created by Jess Le on 3/1/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import Foundation
import UIKit

class MainMapCoordinator: Coordinatable {
    var childCoordinators = [Coordinatable]()
    var rootViewController: UIViewController = UIViewController()
    var window: UIWindow?

    init(window: UIWindow) {
        self.window = window
    }

    /// Responsible for navigating to the login screen initially which will then instantiate and rely on the `LoginCoordinator()`
    ///
    /// - Parameters:
    ///     - destination:  A destination object with all possible screens
    func navigate(to destination: Destination) {
        if case .logout = destination {
            let storyboard = UIStoryboard.storyboard(storyboardName: .login, bundle: Bundle(for: type(of: self)))
            let loginViewController: LoginViewController = storyboard.viewController()
            if let coordinator = childCoordinators.first(where: { $0 is LoginCoordinator }) as? LoginCoordinator {
                window?.rootViewController = coordinator.rootViewController
            }
            rootViewController = loginViewController
        } else if case .mainTabBar(.mainMapView) = destination {
            let storyboard = UIStoryboard.storyboard(storyboardName: .mainMapView, bundle: Bundle(for: type(of: self)))
            let mainMapNavigationController = storyboard.instantiateViewController(identifier: "MainMapNavigation") as UINavigationController
            let viewController: MainMapViewController = storyboard.instantiateViewController(identifier: "MainMapViewController") as MainMapViewController
            mainMapNavigationController.viewControllers = [viewController]
            rootViewController = mainMapNavigationController
            viewController.coordinator = self
        }
    }
}
