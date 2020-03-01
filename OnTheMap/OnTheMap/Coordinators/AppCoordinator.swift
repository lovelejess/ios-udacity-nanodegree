//
//  AppCoordinator.swift
//  OnTheMap
//
//  Created by Jess Le on 3/1/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: Coordinatable {
    var childCoordinators = [Coordinatable]()
    var rootViewController: UIViewController = UIViewController()
    var window: UIWindow?

    init(window: UIWindow) {
        self.window = window
    }

    /// Responsible for navigating to the login screen initially which will then instantiate and rely on the `LoginCoordinator()` for further navigation actions
    ///
    /// - Parameters:
    ///     - destination:  A destination object with all possible screens
    func navigate(to destination: Destination) {
        if case .login = destination {
            guard let window = window else { fatalError("There should always be a uiWindow") }
            if let coordinator = childCoordinators.first(where: { $0 is LoginCoordinator }) as? LoginCoordinator {
                window.rootViewController = coordinator.rootViewController
            } else {
                let coordinator = LoginCoordinator(window: window)
                childCoordinators.append(coordinator)
                coordinator.navigate(to: destination)
                window.rootViewController = coordinator.rootViewController
            }
        }
    }
}
