//
//  SceneDelegate.swift
//  TMDBCoppelTest
//
//  Created by Jael  on 27/02/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let vc = LoginRouter.createLoginModule()
        let navController = UINavigationController(rootViewController: vc)
        self.window = self.window ?? UIWindow()

           // Set this scene's window's background color.
           self.window!.backgroundColor = UIColor.clear

           // Create a ViewController object and set it as the scene's window's root view controller.
           self.window!.rootViewController = navController
 
        
           // Make this scene's window be visible.
           self.window!.makeKeyAndVisible()

           guard scene is UIWindowScene else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
     
    }

    func sceneWillResignActive(_ scene: UIScene) {
   
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
   
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

