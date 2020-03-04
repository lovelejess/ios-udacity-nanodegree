//
//  InformationPostingCoordinator.swift
//  OnTheMap
//
//  Created by Jess Le on 3/1/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import Foundation
import UIKit

class InformationPostingCoordinator {
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
    }
}
