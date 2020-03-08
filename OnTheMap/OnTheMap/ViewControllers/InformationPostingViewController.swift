//
//  InformationPostingViewController.swift
//  OnTheMap
//
//  Created by Jess Le on 3/1/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import UIKit

class InformationPostingViewController: UIViewController {

    weak var coordinator: MainMapCoordinator?
    @IBOutlet weak var linkedInTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var findLocationButton: UIButton!

    var viewModel: InformationPostingViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Location"
        findLocationButton.layer.cornerRadius = 4
    }

    @IBAction func onFindLocationPressed(_ sender: Any) {
//        guard let _ = linkedInTextField.text, let _ = locationTextField.text else {
//            let alert = UIAlertController(title: "Oops!", message: "Please provide a LinkedIn URL", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//            present(alert, animated: true)
//            return
//        }

        let uniqueKey =  "CDHfAy8sdp"
        let firstName = "Zebra"
        let lastName = "Test"
        let address = "Los Angeles, CA"
        let mediaURL = "https://www.youtube.com/watch?v=dQw4w9WgXcQ"

        viewModel?.createStudentLocationRequest(uniqueKey: uniqueKey, firstName: firstName, lastName: lastName, mapString: address, mediaURL: mediaURL)

        coordinator?.navigate(to: .showNewLocation)
    }
}
