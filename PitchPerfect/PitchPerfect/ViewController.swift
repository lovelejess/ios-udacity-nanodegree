//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Jess Le on 11/25/19.
//  Copyright © 2019 lovelejess. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tapToRecordLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!

    @IBAction func onRecordPressed(_ sender: Any) {
        tapToRecordLabel.text = "Recording..."
        stopRecordingButton.isEnabled = true
        recordButton.isEnabled = false
    }

    @IBAction func onStopRecordingPressed(_ sender: Any) {
        tapToRecordLabel.text = "Tap to Record"
        stopRecordingButton.isEnabled = false
        recordButton.isEnabled = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
    }
}
