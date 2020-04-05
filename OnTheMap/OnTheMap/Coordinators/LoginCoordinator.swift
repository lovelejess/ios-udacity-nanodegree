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
    var parentCoordinator: Coordinatable?
    var window: UIWindow?

    init(window: UIWindow) {
        self.window = window
    }

    /// Responsible for navigating to the main tab bar screen initially which will then instantiate and rely on the `TabBarCoordinator()` for further navigation actions
    ///
    /// - Parameters:
    ///     - destination:  A destination object with all possible screens
    func navigate(to destination: Destination) {
        switch destination {
        case .login:
            let storyboard = UIStoryboard.storyboard(storyboardName: .login, bundle: Bundle(for: type(of: self)))
            let loginViewController: LoginViewController = storyboard.viewController()
            loginViewController.coordinator = self
            rootViewController = loginViewController
        case .logout:
            let storyboard = UIStoryboard.storyboard(storyboardName: .login, bundle: Bundle(for: type(of: self)))
            let loginViewController: LoginViewController = storyboard.viewController()
            loginViewController.coordinator = LoginCoordinator(window: window!)
            window?.rootViewController = loginViewController
        case .mainTabBar(.mainMapView):
            childCoordinators.append(self)
            let coordinator = TabBarCoordinator(window: window!)
            childCoordinators.append(coordinator)
            coordinator.parentCoordinator = self
            coordinator.navigate(to: destination)
            window?.rootViewController = coordinator.rootViewController
        default:
            parentCoordinator?.navigate(to: destination)
        }
    }
}
