//
//  SceneDelegate.swift
//  OnTheMap
//
//  Created by Jess Le on 2/23/20.
//  Copyright © 2020 lovelejess. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var appCoordinator: AppCoordinator?
    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {        
        if let windowScene = scene as? UIWindowScene {
           let window = UIWindow(windowScene: windowScene)
           /// `appCoordinator` is instantiated to handle app navigation through use of more coordinators
           appCoordinator = AppCoordinator(window: window)
           appCoordinator?.navigate(to: .login)
           self.window = window
           window.makeKeyAndVisible()
        }
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

