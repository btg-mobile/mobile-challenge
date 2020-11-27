//
//  SceneDelegate.swift
//  mobileChallenge
//
//  Created by Mateus Augusto M Ferreira on 21/11/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    //MARK: - Variables
    /// Variables
    var window: UIWindow?
    var coordinator: Coordinator?
    
    //MARK: - Scene
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        //Instantiate Window
        self.window = UIWindow(windowScene: windowScene)
        
        let navigation = UINavigationController()
        window?.rootViewController = navigation
        
        //Instantiate Coordinator
        self.coordinator = CoordinatorManager(navigationController: navigation)
        
        
        //Call Start Coordinator
        self.coordinator?.start()
        
        
        //Shows Window
        window?.makeKeyAndVisible()
    }

    //MARK: - SceneDidDisconnect
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    //MARK: - SceneDidBecomeActive
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    //MARK: - SceneWillResignActive
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    //MARK: - SceneWillEnterForeground
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    //MARK: - SceneDidEnterBackground
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
    }
}
