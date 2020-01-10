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
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!

    @IBAction func onShareButtonPressed(_ sender: Any) {
        let image = generateMemedImage()
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.completionWithItemsHandler = { (activityType: UIActivity.ActivityType?, completed:
        Bool, arrayReturnedItems: [Any]?, error: Error?) in
            if completed {
                self.save(generatedImage: image)
                return
            }
            if let shareError = error {
                let errorMessage = "Error while sharing: \(shareError.localizedDescription)"
                let alertView = UIAlertController(title: "Error!", message: errorMessage, preferredStyle: .alert)
                self.present(alertView, animated: true)
            }
        }
        present(vc, animated: true)
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

    @IBAction func onCancelButtonPressed(_ sender: Any) {
        memeImage.image = nil
        shareButton.isEnabled = false
        view.backgroundColor = .black
        topTextField.resignFirstResponder()
        bottomTextField.resignFirstResponder()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        topTextField.delegate = self
        bottomTextField.delegate = self
        topTextField.clearsOnBeginEditing = true
        bottomTextField.clearsOnBeginEditing = true
        view.backgroundColor = .black
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        shareButton.isEnabled = false
        subscribeToKeyboardNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        unsubscribeToKeyboardNotifications()
    }
}

extension ViewController {
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }

    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func unsubscribeToKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        if (bottomTextField.isFirstResponder) {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        if (bottomTextField.isFirstResponder) {
            view.frame.origin.y = 0
        }
    }

    func save(generatedImage: UIImage) {
        guard let topText = topTextField.text else { return }
        guard let bottomText = bottomTextField.text else { return }
        guard let image = memeImage.image else { return }
        // Requirements says to create a Meme Struct, but not sure what else to do with it
        let _ = Meme(topText: topText, bottomText: bottomText, originalImage: image, memedImage: generatedImage)
    }

    func generateMemedImage() -> UIImage {
        // Remove Toolbars from view to avoid saving in MemedImage
        topToolbar.isHidden = true
        bottomToolbar.isHidden = true
        // Render view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawHierarchy(in: view.frame, afterScreenUpdates: true)
        let generatedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        // Add Toolbars back
        topToolbar.isHidden = false
        bottomToolbar.isHidden = false
        return generatedImage
    }
}


extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            memeImage.image = image
            memeImage.contentMode = .scaleAspectFit
            topTextField.isHidden = false
            bottomTextField.isHidden = false
            shareButton.isEnabled = true
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

public struct Meme {
    var topText: String
    var bottomText: String
    var originalImage: UIImage
    var memedImage: UIImage
}
