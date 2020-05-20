//
//  PhotoCollectionViewCell.swift
//  VirtualTourist
//
//  Created by Jess Le on 5/18/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeCell()
     }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initializeCell()
    }

    private func initializeCell() {
        layer.cornerRadius = 5
        layer.masksToBounds = true
        backgroundColor = UIColor.blue
    }
}
