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

    /// Responsible for instantiating and pushing views to the stack by relying on its navigation controllers
    ///
    /// - Parameters:
    ///     - destination:  A destination ob`ject with all possible screens
    func navigate(to destination: Destination) {
        switch (destination) {
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

        case .mainTabBar(.mainMapView):
            let storyboard = UIStoryboard.storyboard(storyboardName: .mainMapView, bundle: Bundle(for: type(of: self)))
            let mainMapNavigationController = storyboard.viewController(for: .mainMapNavigation) as UINavigationController
            let viewController = storyboard.viewController(for: .mainMapViewController) as MainMapViewController
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
