//
//  InformationPostingViewController.swift
//  OnTheMap
//
//  Created by Jess Le on 3/1/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import UIKit

class InformationPostingViewController: UIViewController {

    weak var coordinator: Coordinatable?
    @IBOutlet weak var linkedInTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var findLocationButton: UIButton!

    var viewModel: InformationPostingViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Location"
        findLocationButton.layer.cornerRadius = 4
    }

    @IBAction func onFindLocationPressed(_ sender: Any) {
        guard let linkedInURL = linkedInTextField.text, let location = locationTextField.text, let firstName = firstNameTextField.text, let lastName = lastNameTextField.text else {
            let alert = UIAlertController(title: "Oops!", message: "Please fill in all fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
        }

        viewModel?.createStudentLocationRequest(uniqueKey:  UUID().uuidString, firstName: firstName, lastName: lastName, mapString: location, mediaURL: linkedInURL)

        coordinator?.navigate(to: .showNewLocation)
    }
}
