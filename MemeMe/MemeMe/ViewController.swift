//
//  ViewController.swift
//  MemeMe
//
//  Created by Jess Le on 12/26/19.
//  Copyright © 2019 lovelejess. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var photoAlbumButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var topTextField: MemeTextField!
    @IBOutlet weak var bottomTextField: MemeTextField!

    @IBAction func shareButton(_ sender: Any) {
        if let image = memeImage.image {
            let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
            present(vc, animated: true)
        }
    }

    @IBAction func cancelButton(_ sender: Any) {
        memeImage.image = nil
        memeImage.contentMode = .scaleToFill
        topTextField.isHidden = true
        bottomTextField.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        topTextField.delegate = self
        bottomTextField.delegate = self
        topTextField.isHidden = true
        bottomTextField.isHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)

    }

    @IBAction func selectFromLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

    @IBAction func selectFromCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            memeImage.image = image
            memeImage.contentMode = .scaleToFill
            topTextField.isHidden = false
            bottomTextField.isHidden = false
            topTextField.attributedText = NSAttributedString(string: "TOP")
            bottomTextField.attributedText = NSAttributedString(string: "BOTTOM")
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension ViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
