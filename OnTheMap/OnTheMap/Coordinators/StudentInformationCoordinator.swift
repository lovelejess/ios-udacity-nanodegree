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
            let studentInfoNavigationController = storyboard.instantiateViewController(identifier: "StudentInformationNavController") as UINavigationController
            let viewController: StudentInformationViewController = storyboard.instantiateViewController(identifier: "StudentInformationViewController") as StudentInformationViewController
            viewController.viewModel = StudentInformationViewModel()
            viewController.coordinator = self
            studentInfoNavigationController.viewControllers = [viewController]
            rootViewController = studentInfoNavigationController
            
        case .addPin:
            let storyboard = UIStoryboard.storyboard(storyboardName: .addPin, bundle: Bundle(for: type(of: self)))
            let viewController: InformationPostingViewController = storyboard.instantiateViewController(identifier: "InformationPostingViewController") as InformationPostingViewController
            viewController.coordinator = self

            if let _ = rootViewController.children.first(where: { $0 is StudentInformationViewController }) as? StudentInformationViewController {
                let viewModel = InformationPostingViewModel()
                viewController.viewModel = viewModel
            }

            navigationController?.pushViewController(viewController, animated: true)

        case .showNewLocation:
            let storyboard = UIStoryboard.storyboard(storyboardName: .addPin, bundle: Bundle(for: type(of: self)))
            let viewController: InformationLocationViewController = storyboard.instantiateViewController(identifier: "InformationLocationViewController") as InformationLocationViewController
            viewController.coordinator = self
            let children = rootViewController.children
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
