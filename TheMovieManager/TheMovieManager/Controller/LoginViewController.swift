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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        TMDBClient.getRequestToken { (isSuccessful, error) in
            self.handleRequestTokenResponse(isSuccessful: isSuccessful, error: error)
        }
    }
    
    @IBAction func loginViaWebsiteTapped()   {
        TMDBClient.getRequestToken { (isSuccessful, error) in
            if isSuccessful {
                DispatchQueue.main.async {
                    UIApplication.shared.open(TMDBClient.Endpoints.webAuth.url, options: [:], completionHandler: nil)
                    }
                }
            }
        }
    
    func handleRequestTokenResponse(isSuccessful: Bool, error: Error?) {
        if isSuccessful {
            print("Request Token: \(TMDBClient.Auth.requestToken)")
            DispatchQueue.main.async { // because we're accessing these ui components on a completion handler that might be executed in the background, need to wrap in call in async
                TMDBClient.login(username: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "", completion: self.handleLoginResponse(isSuccessful:error:))
            }
        }
    }
    
    func handleLoginResponse(isSuccessful: Bool, error: Error?) {
        if isSuccessful {
            print("Login Response Request Token: \(TMDBClient.Auth.requestToken)")
            TMDBClient.getSessionId(completion: self.handleSessionResponse(isSuccessful:error:))
        }
    }
    
    func handleSessionResponse(isSuccessful: Bool, error: Error?) {
        if isSuccessful {
            print("SessionID: \(TMDBClient.Auth.sessionId)")
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "completeLogin", sender: nil)
            }
        }
    }
    
}
