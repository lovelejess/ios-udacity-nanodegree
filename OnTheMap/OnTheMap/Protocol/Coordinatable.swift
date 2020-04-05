//
//  Coordinatable.swift
//  OnTheMap
//
//  Created by Jess Le on 3/1/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinatable: class {
    var childCoordinators: [Coordinatable] { get set }
    var rootViewController: UIViewController { get set }

    func navigate(to destination: Destination)
}
