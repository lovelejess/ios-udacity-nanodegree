//
//  AppCoordinator.swift
//  VirtualTourist
//
//  Created by Jess Le on 4/24/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: Coordinatable {
    var window: UIWindow!
    var childControllers: [UIViewController]?
    var parentCoordinator: Coordinatable?
    var userPreferences: UserPreferences!
    var dataController: DataController!
    var rootViewController: UIViewController!

    init(window: UIWindow, userPreferences: UserPreferences = UserPreferences(), dataController: DataController) {
        self.window = window
        self.userPreferences = userPreferences
        self.dataController = dataController
    }

    func navigate(to route: Route) {
        switch route {
        case .travelLocationsMap:
            let storyboard = UIStoryboard.storyboard(storyboardName: .travelLocationsMap, bundle: Bundle(for: type(of: self)))
            let navigationController = storyboard.viewController(for: .travelLocationMapNavigation) as UINavigationController
            let viewController = storyboard.viewController(for: .travelLocationMapViewController) as TravelLocationMapViewController
            navigationController.viewControllers = [viewController]
            viewController.viewModel = TravelLocationViewModel(coordinator: self, userPreferences: userPreferences, dataController: dataController)
            window.rootViewController = navigationController
            rootViewController = navigationController
        case .photoAlbum:
            let storyboard = UIStoryboard.storyboard(storyboardName: .photoAlbum, bundle: Bundle(for: type(of: self)))
            let viewController = storyboard.viewController(for: .photoAlbumViewController) as PhotoAlbumViewController
            viewController.viewModel = PhotoAlbumViewModel(coordinator: self, userPreferences: userPreferences, dataController: dataController)

            if rootViewController.children.first(where: { $0 is TravelLocationMapViewController}) != nil {
                rootViewController.present(viewController, animated: true, completion: nil)
            }
            
        }
    }
}
