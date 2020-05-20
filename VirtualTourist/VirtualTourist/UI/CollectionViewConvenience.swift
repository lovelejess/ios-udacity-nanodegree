//
//  CollectionViewConvenience.swift
//  VirtualTourist
//
//  Created by Jess Le on 5/2/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import Foundation
import UIKit

protocol CollectionViewIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension CollectionViewIdentifiable where Self: UICollectionViewCell {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: CollectionViewIdentifiable { }

extension UICollectionView {
    func dequeueCell<T>(indexPath: IndexPath) -> T where T: UICollectionViewCell {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.storyboardIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue cell with identifier \(T.storyboardIdentifier)")
        }

        return cell
    }
}
