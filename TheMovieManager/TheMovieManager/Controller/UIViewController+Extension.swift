//
//  UIViewController+Extension.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

extension UIViewController {
    
    @IBAction func logoutTapped(_ sender: UIBarButtonItem) {
        TMDBClient.logout(sessionId: TMDBClient.Auth.sessionId) { (isSuccessful, error) in
            DispatchQueue.main.async {
                self.handleLogout(isSuccessful: isSuccessful, error: error)
            }
        }
    }
    
    func handleLogout(isSuccessful: Bool, error: Error?) {
        if isSuccessful {
            print("logging out")
            self.dismiss(animated: true, completion: nil)
        }
        else {
            print("Unable to logout. Try Again")
            showFailureAlert(message: error?.localizedDescription ?? "")
        }
    }
    
    func showFailureAlert(message: String) {
        let alertVC = UIAlertController(title: "Error Occurred", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
}
