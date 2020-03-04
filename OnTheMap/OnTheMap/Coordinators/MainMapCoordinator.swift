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
    var parentCoordinator: Coordinatable?
    var window: UIWindow?

    var navigationController: UINavigationController? {
        return (rootViewController as? UINavigationController)
    }

    init(window: UIWindow) {
        self.window = window
    }

    /// Responsible for navigating to the login screen initially which will then instantiate and rely on the `LoginCoordinator()`
    ///
    /// - Parameters:
    ///     - destination:  A destination ob`ject with all possible screens
    func navigate(to destination: Destination) {
        switch (destination) {
        case .logout:
            let storyboard = UIStoryboard.storyboard(storyboardName: .login, bundle: Bundle(for: type(of: self)))
            let loginViewController: LoginViewController = storyboard.viewController()
            loginViewController.coordinator = LoginCoordinator(window: window!)
            window?.rootViewController = loginViewController
        case .addPin:
            let storyboard = UIStoryboard.storyboard(storyboardName: .addPin, bundle: Bundle(for: type(of: self)))
            let viewController: InformationPostingViewController = storyboard.instantiateViewController(identifier: "InformationPostingViewController") as InformationPostingViewController
            rootViewController.present(viewController, animated: true) {
                print("")
            }
        case .mainTabBar(.mainMapView):
            let storyboard = UIStoryboard.storyboard(storyboardName: .mainMapView, bundle: Bundle(for: type(of: self)))
            let mainMapNavigationController = storyboard.instantiateViewController(identifier: "MainMapNavigation") as UINavigationController
            let viewController: MainMapViewController = storyboard.instantiateViewController(identifier: "MainMapViewController") as MainMapViewController
            mainMapNavigationController.viewControllers = [viewController]
            rootViewController = mainMapNavigationController
            print("rootViewController \(rootViewController)")
            viewController.coordinator = self
        default:
            parentCoordinator?.navigate(to: .logout)
        }
    }
}
