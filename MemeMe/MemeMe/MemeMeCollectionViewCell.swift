//
//  MemeMeCollectionViewCell.swift
//  MemeMe
//
//  Created by Jess Le on 1/18/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import UIKit

class MemeMeCollectionViewCell: UICollectionViewCell {

    var imageSize:CGFloat?

    var memeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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

        self.addSubview(memeImage)
        setImageLayout()
    }

    private func setImageLayout() {
        memeImage.centerXAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerXAnchor).isActive = true
        memeImage.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor).isActive = true
     }
}
