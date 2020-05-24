//
//  PhotoCollectionViewCell.swift
//  VirtualTourist
//
//  Created by Jess Le on 5/18/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

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
        addSubview(label)
        setLabelLayout()
    }

    private func setLabelLayout() {
       label.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor).isActive = true
       label.centerXAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
    
    public func configure(photo: Photo) {
        label.text = photo.title
    }
}
