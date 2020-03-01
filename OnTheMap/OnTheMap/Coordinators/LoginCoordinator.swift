//
//  LoginCoordinator.swift
//  OnTheMap
//
//  Created by Jess Le on 3/1/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import Foundation
import UIKit

class LoginCoordinator: Coordinatable {
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
        if case .login = destination {
            let storyboard = UIStoryboard.storyboard(storyboardName: .login, bundle: Bundle(for: type(of: self)))
            let loginViewController: LoginViewController = storyboard.viewController()
            loginViewController.coordinator = self
            rootViewController = loginViewController
        } else if case .mainMapView = destination {
            let storyboard = UIStoryboard.storyboard(storyboardName: .mainMapView, bundle: Bundle(for: type(of: self)))
            let mainMapNavigationController = storyboard.instantiateViewController(identifier: "MainMapNavigation") as UINavigationController
            let mainTabBarViewController = storyboard.instantiateViewController(identifier: "MainTabBarView") as UITabBarController
            let viewController: MainMapViewController = storyboard.viewController()
            mainTabBarViewController.viewControllers = [viewController]
            mainMapNavigationController.viewControllers = [mainTabBarViewController]
            window?.rootViewController = mainMapNavigationController

            let coordinator = MainMapCoordinator(window: window!)
            childCoordinators.append(coordinator)
            viewController.coordinator = coordinator
        }
    }
}
