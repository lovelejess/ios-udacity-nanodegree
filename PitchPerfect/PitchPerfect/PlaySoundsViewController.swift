//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Jess Le on 11/30/19.
//  Copyright © 2019 lovelejess. All rights reserved.
//

import UIKit

class PlaySoundsViewController: UIViewController {

    var recordedAudioURL: URL!
    
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var lowPitchButton: UIButton!
    @IBOutlet weak var highPitchButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("RECORDED AUDIO URL: \(recordedAudioURL)")

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
