//
//  StudentInformationCoordinator.swift
//  OnTheMap
//
//  Created by Jess Le on 3/15/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import Foundation
import UIKit

class StudentInformationCoordinator: Coordinatable {
    var childCoordinators = [Coordinatable]()
    var rootViewController: UIViewController = UIViewController()
    var parentCoordinator: Coordinatable?
    var window: UIWindow?

    init(window: UIWindow) {
        self.window = window
    }

    func navigate(to destination: Destination) {
        switch (destination) {
        case .mainTabBar(.studentInfo):
            let storyboard = UIStoryboard.storyboard(storyboardName: .studentInfo, bundle: Bundle(for: type(of: self)))
            let viewController: StudentInformationViewController = storyboard.instantiateViewController(identifier: "StudentInformationViewController") as StudentInformationViewController
            viewController.viewModel = StudentInformationViewModel()
            rootViewController = viewController
            viewController.coordinator = self
        default:
            parentCoordinator?.navigate(to: .logout)
        }
    }
}
