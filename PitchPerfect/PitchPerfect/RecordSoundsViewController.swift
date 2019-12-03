//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Jess Le on 11/25/19.
//  Copyright © 2019 lovelejess. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController {

    @IBOutlet weak var tapToRecordLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!

    // MARK: Properties

    var audioRecorder: AVAudioRecorder!

    @IBAction func onRecordPressed(_ sender: Any) {
        toggleRecordButtonState(isRecording: true)

        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]

        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)

        let filePath = URL(string: pathArray.joined(separator: "/"))
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    @IBAction func onStopRecordingPressed(_ sender: Any) {
        toggleRecordButtonState(isRecording: false)

        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            playSoundsVC.recordedAudioURL = sender as? URL
        }
    }

    private func toggleRecordButtonState(isRecording: Bool) {
        if isRecording {
            tapToRecordLabel.text = "Recording..."
            stopRecordingButton.isEnabled = true
            recordButton.isEnabled = false
        } else {
            tapToRecordLabel.text = "Tap to Record"
            stopRecordingButton.isEnabled = false
            recordButton.isEnabled = true
        }
    }
}

extension RecordSoundsViewController: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            Alerts.showAlert(AlertType.AudioEngineError, message: String(describing: "Problem saving audio"), sender: self)
        }
    }
}
