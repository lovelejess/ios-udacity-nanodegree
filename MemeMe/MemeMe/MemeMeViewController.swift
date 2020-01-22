//
//  MemeMeViewController.swift
//  MemeMe
//
//  Created by Jess Le on 12/26/19.
//  Copyright © 2019 lovelejess. All rights reserved.
//

import UIKit

class MemeMeViewController: UIViewController {

    @IBOutlet weak var photoAlbumButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var topTextField: MemeTextField!
    @IBOutlet weak var bottomTextField: MemeTextField!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!

    @objc func onShareButtonPressed(_ sender: Any) {
        let image = generateMemedImage()
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        present(vc, animated: true, completion: {
            self.save(generatedImage: image)
        })
    }

    @IBAction func selectFromLibrary() {
        let imagePicker = createImagePicker(sourceType: .photoLibrary)
        present(imagePicker, animated: true, completion: nil)
    }

    @IBAction func selectFromCamera() {
        let imagePicker = createImagePicker(sourceType: .camera)
        present(imagePicker, animated: true, completion: nil)
    }

    @IBAction func onCancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        topTextField.delegate = self
        bottomTextField.delegate = self
        topTextField.clearsOnBeginEditing = true
        bottomTextField.clearsOnBeginEditing = true
        view.backgroundColor = .black
        self.navigationItem.rightBarButtonItem = shareButton
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

// MARK: Keyboard private methods
extension MemeMeViewController {
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
        if bottomTextField.isFirstResponder {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = 0
        }
    }

    func save(generatedImage: UIImage) {
        guard let topText = topTextField.text else { return }
        guard let bottomText = bottomTextField.text else { return }
        guard let image = memeImage.image else { return }

        // Create the meme
        let meme = Meme(topText: topText, bottomText: bottomText, originalImage: image, memedImage: generatedImage)

        // Add it to the memes array in the Application Delegate
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }

    func generateMemedImage() -> UIImage {
        // Remove Toolbars from view to avoid saving in MemedImage
        topToolbar?.isHidden = true
        bottomToolbar.isHidden = true
        // Render view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawHierarchy(in: view.frame, afterScreenUpdates: true)
        let generatedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        // Add Toolbars back
        topToolbar?.isHidden = false
        bottomToolbar.isHidden = false
        return generatedImage
    }
}

// MARK: UIImagePicker delegates
extension MemeMeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            memeImage.image = image
            memeImage.contentMode = .scaleAspectFit
        }
        dismiss(animated: true, completion: {
            self.shareButton.isEnabled = true
        })
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: UITextField delegates
extension MemeMeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension MemeMeViewController {
    func createImagePicker(sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        return imagePicker
    }

    func setTextFieldText(for textField: UITextField, text: String) {
        textField.attributedText = NSAttributedString(string: text)
    }
}
