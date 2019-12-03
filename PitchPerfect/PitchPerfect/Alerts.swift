//
//  AlertType.swift
//  PitchPerfect
//
//  Created by Jess Le on 12/2/19.
//  Copyright © 2019 lovelejess. All rights reserved.
//

import Foundation
import UIKit

public class Alerts {
    // MARK: Alerts

    public static func showAlert(_ title: String, message: String, sender: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: AlertType.DismissAlert, style: .default, handler: nil))
        sender.present(alert, animated: true, completion: nil)
    }
}

public struct AlertType {
       static let DismissAlert = "Dismiss"
       static let RecordingDisabledTitle = "Recording Disabled"
       static let RecordingDisabledMessage = "You've disabled this app from recording your microphone. Check Settings."
       static let RecordingFailedTitle = "Recording Failed"
       static let RecordingFailedMessage = "Something went wrong with your recording."
       static let AudioRecorderError = "Audio Recorder Error"
       static let AudioSessionError = "Audio Session Error"
       static let AudioRecordingError = "Audio Recording Error"
       static let AudioFileError = "Audio File Error"
       static let AudioEngineError = "Audio Engine Error"
   }
