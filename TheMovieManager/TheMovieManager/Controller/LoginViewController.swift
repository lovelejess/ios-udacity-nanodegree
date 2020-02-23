//
//  LoginViewController.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginViaWebsiteButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        setLoggingIn(isLoggingIn: true)
        TMDBClient.getRequestToken { (isSuccessful, error) in
            self.handleRequestTokenResponse(isSuccessful: isSuccessful, error: error)
        }
    }
    
    @IBAction func loginViaWebsiteTapped() {
        setLoggingIn(isLoggingIn: true)
        TMDBClient.getRequestToken { (isSuccessful, error) in
            if isSuccessful {
                UIApplication.shared.open(TMDBClient.Endpoints.webAuth.url, options: [:], completionHandler: nil)
            }else {
                self.showFailureAlert(message: error?.localizedDescription ?? "")
                self.setLoggingIn(isLoggingIn: false)
            }
        }
    }
    
    func handleRequestTokenResponse(isSuccessful: Bool, error: Error?) {
        if isSuccessful {
            print("Request Token: \(TMDBClient.Auth.requestToken)")
            TMDBClient.login(username: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "", completion: self.handleLoginResponse(isSuccessful:error:))
        } else {
            showFailureAlert(message: error?.localizedDescription ?? "")
            self.setLoggingIn(isLoggingIn: false)
        }
    }
    
    func handleLoginResponse(isSuccessful: Bool, error: Error?) {
        if isSuccessful {
            print("Login Response Request Token: \(TMDBClient.Auth.requestToken)")
            TMDBClient.getSessionId(completion: self.handleSessionResponse(isSuccessful:error:))
        } else {
            showFailureAlert(message: error?.localizedDescription ?? "")
            self.setLoggingIn(isLoggingIn: false)
        }
    }
    
    func handleSessionResponse(isSuccessful: Bool, error: Error?) {
        setLoggingIn(isLoggingIn: false)
        if isSuccessful {
            print("SessionID: \(TMDBClient.Auth.sessionId)")
            self.performSegue(withIdentifier: "completeLogin", sender: nil)
        } else {
            showFailureAlert(message: error?.localizedDescription ?? "")
            self.setLoggingIn(isLoggingIn: false)
        }
    }
    
    func setLoggingIn(isLoggingIn: Bool) {
        if isLoggingIn {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        
        emailTextField.isEnabled = !isLoggingIn
        passwordTextField.isEnabled = !isLoggingIn
        loginButton.isEnabled = !isLoggingIn
        loginViaWebsiteButton.isEnabled = !isLoggingIn
    }
    
}
