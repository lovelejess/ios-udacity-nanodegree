//
//  InformationPostingViewController.swift
//  OnTheMap
//
//  Created by Jess Le on 3/1/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import UIKit
import MapKit

class InformationPostingViewController: UIViewController {

    @IBOutlet weak var linkedInTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var findLocationButton: UIButton!
    
    weak var mapViewDelegate: MapViewDelegate?

    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Location"
        findLocationButton.layer.cornerRadius = 4
    }

    @IBAction func onFindLocationPressed(_ sender: Any) {
//        if let text = linkedInTextField.text, text.isEmpty {
//            let alert = UIAlertController(title: "Oops!", message: "Please provide a LinkedIn URL", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//            present(alert, animated: true)
//        } else {
//            self.dismiss(animated: true) {
//                // TODO: Convert text -> MKCoordinateRegion
//                let chicago = CLLocation(latitude: 41.8781, longitude: 87.6298)
//                self.mapViewDelegate?.reload(with: chicago)
//            }
//        }
        self.dismiss(animated: true) {
            // TODO: Convert text -> MKCoordinateRegion
            let johns = CLLocation(latitude: 42.086850, longitude: -87.997690)
            self.mapViewDelegate?.reload(with: johns)
        }
    }
}


protocol MapViewDelegate: class {
    func reload(with location: CLLocation)
}
