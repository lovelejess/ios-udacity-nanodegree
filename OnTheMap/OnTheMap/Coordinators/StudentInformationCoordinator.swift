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

    var navigationController: UINavigationController? {
        return (rootViewController as? UINavigationController)
    }

    init(window: UIWindow) {
        self.window = window
    }

    func navigate(to destination: Destination) {
        switch (destination) {
        case .mainTabBar(.studentInfo):
            let storyboard = UIStoryboard.storyboard(storyboardName: .studentInfo, bundle: Bundle(for: type(of: self)))
            let studentInfoNavigationController = storyboard.viewController(for: .studentInformationNavController) as UINavigationController
            let viewController = storyboard.viewController(for: .studentInformationViewController) as StudentInformationViewController
            viewController.viewModel = StudentInformationViewModel()
            viewController.coordinator = self
            studentInfoNavigationController.viewControllers = [viewController]
            rootViewController = studentInfoNavigationController

        case .addPin:
            let storyboard = UIStoryboard.storyboard(storyboardName: .addPin, bundle: Bundle(for: type(of: self)))
            let viewController = storyboard.viewController(for: .informationPostingViewController) as InformationPostingViewController
            viewController.coordinator = self
            let viewModel = InformationPostingViewModel()
            viewController.viewModel = viewModel

            navigationController?.pushViewController(viewController, animated: true)

        case .showNewLocation:
            let storyboard = UIStoryboard.storyboard(storyboardName: .addPin, bundle: Bundle(for: type(of: self)))
            let viewController = storyboard.viewController(for: .informationLocationViewController) as InformationLocationViewController
            viewController.coordinator = self
            let children = rootViewController.children

            // Only set the InformationLocationViewController's view model, if we've already navigated to the InformationPostingViewController,
            // so that they share the same View Model
            if let informationPostingViewController = children.last(where: { $0 is InformationPostingViewController }) as? InformationPostingViewController {
                viewController.viewModel = informationPostingViewController.viewModel
            }
            rootViewController.present(viewController, animated: true, completion: nil)

        case .root:
            navigationController?.popToRootViewController(animated: true)
        default:
            parentCoordinator?.navigate(to: .logout)
        }
    }
}
