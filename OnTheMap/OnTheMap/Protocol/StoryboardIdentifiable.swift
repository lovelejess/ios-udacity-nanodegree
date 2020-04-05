//
//  StoryboardIdentifiable.swift
//  OnTheMap
//
//  Created by Jess Le on 3/1/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import Foundation
import UIKit

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

extension UIViewController: StoryboardIdentifiable { }

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
