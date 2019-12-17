//
//  RoshamboViewController.swift
//  Roshambo
//
//  Created by Jess Le on 12/14/19.
//  Copyright © 2019 lovelejess. All rights reserved.
//

import UIKit

class RoshamboViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var rockButton: UIButton!

    @IBOutlet weak var paperButton: UIButton!

    @IBOutlet weak var scissorsButton: UIButton!

    var selectedType: RoshamboType?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func roshamboSelected(_ sender: UIButton) {
        let imageName = sender.accessibilityIdentifier
        if let selectedType = getRoshamboType(for: imageName!) {
            self.selectedType = selectedType
            performSegue(withIdentifier: "showResultsView", sender: self)
        } else {
            print("error! Unable to show results!")
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResultsView" {
            if let resultsViewController = segue.destination as? ResultsViewController {
                resultsViewController.userSelectedType = selectedType
            }
            else{
                print("error! Unable to load results!")
            }
        }
    }

    func getRoshamboType(for type: String) -> RoshamboType? {
        return RoshamboType(rawValue: type)
    }
}

enum RoshamboType: String {
    case rock = "rock"
    case paper = "paper"
    case scissors = "scissors"
}
