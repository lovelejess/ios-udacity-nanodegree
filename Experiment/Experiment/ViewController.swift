//
//  ViewController.swift
//  Experiment
//
//  Created by Jess Le on 12/14/19.
//  Copyright © 2019 lovelejess. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var button: UIButton?
    lazy var presentButton: UIButton = {
       let button = UIButton()
        button.setTitle("Present", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(experiment), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.addSubview(presentButton)
        view.backgroundColor = .purple

        NSLayoutConstraint.activate([
            presentButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            presentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
                
    }

    @objc func experiment() {
        let imagePickerController = UIImagePickerController()
//        present(imagePickerController, animated: true, completion: nil)

        let alertViewController = UIAlertController()
        let action = UIAlertAction(title: "ok", style: .default, handler: { action in
            self.dismiss(animated: true, completion: nil)
        })
        alertViewController.title = "Test Alert"
        alertViewController.message = "Test Alert Message"
        alertViewController.addAction(action)
        present(alertViewController, animated: true, completion: nil)
        
    }


}

