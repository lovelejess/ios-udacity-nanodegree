//
//  ViewController.swift
//  MemeMe
//
//  Created by Jess Le on 12/26/19.
//  Copyright © 2019 lovelejess. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var toolBar: UIToolbar = {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 44))
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        return toolBar
    }()

    lazy var libraryButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(selectFromLibrary))
        button.width = 44
        return button
    }()
    
    lazy var cameraButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.camera, target: self, action: #selector(selectFromCamera))
        button.width = 44
        return button
    }()
    
    lazy var topLabel: UILabel = {
        let label = UILabel()
        label.text = "TOP"
        label.textColor = .cyan
        return label
    }()
    
    lazy var bottomLabel: UILabel = {
        let label = UILabel()
        label.text = "BOTTOM"
        label.textColor = .cyan
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        view.addSubview(toolBar)
        view.addSubview(topLabel)
        toolBar.setItems([libraryButton, cameraButton], animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)

        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 500),
            imageView.widthAnchor.constraint(equalToConstant: 500),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            topLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            topLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            toolBar.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            toolBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolBar.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    @objc func selectFromLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

    @objc func selectFromCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
            imageView.contentMode = .scaleToFill
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
