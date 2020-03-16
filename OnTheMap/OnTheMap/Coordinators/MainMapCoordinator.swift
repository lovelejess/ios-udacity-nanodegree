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
        case .addPin:
            let storyboard = UIStoryboard.storyboard(storyboardName: .addPin, bundle: Bundle(for: type(of: self)))
            let viewController: InformationPostingViewController = storyboard.instantiateViewController(identifier: "InformationPostingViewController") as InformationPostingViewController
            viewController.coordinator = self

            // Sets InformationPostingViewController informationPostingViewDelegate to the MainMapViewController if it has already navigated to it
            if let _ = rootViewController.children.first(where: { $0 is MainMapViewController }) as? MainMapViewController {
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

        case .mainTabBar(.mainMapView):
            let storyboard = UIStoryboard.storyboard(storyboardName: .mainMapView, bundle: Bundle(for: type(of: self)))
            let mainMapNavigationController = storyboard.instantiateViewController(identifier: "MainMapNavigation") as UINavigationController
            let viewController: MainMapViewController = storyboard.instantiateViewController(identifier: "MainMapViewController") as MainMapViewController
            viewController.viewModel = MapViewModel()
            mainMapNavigationController.viewControllers = [viewController]
            viewController.coordinator = self
            rootViewController = mainMapNavigationController
            
        case .root:
            navigationController?.popToRootViewController(animated: false)
        default:
            parentCoordinator?.navigate(to: .logout)
        }
    }
}
