//
//  MemeMeDetailsViewController.swift
//  MemeMe
//
//  Created by Jess Le on 1/21/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import UIKit

class MemeMeDetailsViewController: UIViewController {

    var memeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(memeImageView)
        addLayoutConstraints()
    }

    func addLayoutConstraints() {
        memeImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        memeImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
}
