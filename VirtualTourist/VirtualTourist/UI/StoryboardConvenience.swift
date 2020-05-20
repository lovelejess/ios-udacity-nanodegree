//
//  StoryboardConvenience.swift
//  VirtualTourist
//
//  Created by Jess Le on 4/24/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import Foundation
import UIKit

// MARK: StoryboardNames enum
enum StoryboardNames: String {
    case travelLocationsMap = "TravelLocationsMap"
    case photoAlbum = "PhotoAlbum"
}

// MARK: ViewControllerNames enum
enum ViewControllerNames: String {
    case travelLocationMapNavigation = "TravelLocationMapNavigation"
    case travelLocationMapViewController = "TravelLocationMapViewController"
    case photoAlbumViewController = "PhotoAlbumViewController"
}

// MARK: StoryboardIdentifiable protocol
protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

// MARK: StoryboardIdentifiable
extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

// MARK: UIViewController Extension
extension UIViewController: StoryboardIdentifiable { }

// MARK: Storyboard Extension
extension UIStoryboard {
    class func storyboard(storyboardName: StoryboardNames, bundle: Bundle?) -> UIStoryboard {
        return UIStoryboard(name: storyboardName.rawValue, bundle: bundle)
    }

    func viewController<T>() -> T where T: UIViewController {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Unable to instantiate ViewController with identifier \(T.storyboardIdentifier)")
        }

        return viewController
    }

    func viewController<T>(for name: ViewControllerNames) -> T {
        guard let viewController = self.instantiateViewController(withIdentifier: name.rawValue) as? T else {
            fatalError("Unable to instantiate ViewController with identifier \(name.rawValue)")
        }

        return viewController
    }
}
