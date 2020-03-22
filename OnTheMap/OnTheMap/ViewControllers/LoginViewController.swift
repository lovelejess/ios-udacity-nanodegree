//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Jess Le on 2/23/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    var coordinator: LoginCoordinator?

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpLink: LinkTextView!
    @IBOutlet weak var loginButton: UIButton!

    @IBAction func onLoginButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        UdacityClient.login(username: email, password: password, completion: self.handleLogin(sessionResponse:error:))
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loginButton.layer.cornerRadius = 4
        signUpLink.stylizeLinks(text: "Don't have an account? Sign Up", links: ["Sign Up" : "https://auth.udacity.com/sign-up"])
    }
    
    func handleLogin(sessionResponse: SessionResponse?, error: Error?) {
        if (sessionResponse != nil) {
            print("Auth session ID: \(UdacityClient.Auth.sessionId)")
            coordinator?.navigate(to: .mainTabBar(.mainMapView))
        } else {
            let alert = UIAlertController(title: "Oops!", message: "Unable to login!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true)
        }
    }

}
