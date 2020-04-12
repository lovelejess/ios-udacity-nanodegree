//
//  InformationPostingViewController.swift
//  OnTheMap
//
//  Created by Jess Le on 3/1/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import UIKit

class InformationPostingViewController: UIViewController {
    let QuickTypeBarHeight:CGFloat = 72

    weak var coordinator: Coordinatable?
    @IBOutlet weak var linkedInTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var findLocationButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!

    public var isKeyboardDisplayed = false

    var viewModel: InformationPostingViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Location"
        findLocationButton.layer.cornerRadius = 4

        NotificationCenter.default.addObserver(self,
                                              selector: #selector(keyboardWillShow(notification:)),
                                              name: UIResponder.keyboardWillShowNotification,
                                              object: nil)
    }

    @IBAction func onFindLocationPressed(_ sender: Any) {
        guard let linkedInURL = linkedInTextField.text, let location = locationTextField.text, let firstName = firstNameTextField.text, let lastName = lastNameTextField.text else {
            let alert = UIAlertController(title: "Oops!", message: "Please fill in all fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
        }

        guard let key = UserDefaults.standard.string(forKey: "key") else {
            let alert = UIAlertController(title: "Oops!", message: "Unable to find user. Please login again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
        }
        
        let spinnerView = createSpinnerView()
       
        viewModel?.getCoordinateFrom(mapString: location) { coordinate, error in

            guard let coordinate = coordinate else {
                self.disableSpinnerView(child: spinnerView, completion: nil)
                let alert = UIAlertController(title: "Error", message: "Invalid Coordinates. Re-enter another one.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true)
                return
            }
            self.viewModel?.studentLocationRequest = StudentLocationRequest(uniqueKey: key, firstName: firstName, lastName: lastName, mapString: location, mediaURL: linkedInURL, longitude: coordinate.longitude, latitude: coordinate.latitude)

            let doThisAction = {  self.go() }
            self.disableSpinnerView(child: spinnerView, completion: doThisAction)
        }
    }

    func go() {
         self.coordinator?.navigate(to: .showNewLocation)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if isKeyboardDisplayed {
            return
        }
        isKeyboardDisplayed = !self.isKeyboardDisplayed

        var textField: UITextField
        if(firstNameTextField.isFirstResponder) {
            textField = firstNameTextField
        } else if (lastNameTextField.isFirstResponder) {
            textField = firstNameTextField
        } else if (locationTextField.isFirstResponder) {
            textField = locationTextField
        } else if (linkedInTextField.isFirstResponder) {
            textField = linkedInTextField
        }
        else {
            return
        }
        let userInfo = notification.userInfo
        let keyboardFrame = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        let contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardFrame.height + QuickTypeBarHeight, right: 0.0)
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
        scrollView.scrollRectToVisible(textField.frame, animated: true)
    }
}
