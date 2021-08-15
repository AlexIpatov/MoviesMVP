//
//  SceneDelegate.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 04.05.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appStartManager: AppStartManager?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene

        appStartManager = AppStartManager(window: window)
        appStartManager?.start()
        ////TESTSSSadxdqSqs/
       // awdawdawwadawdawd
    }
    func sceneDidEnterBackground(_ scene: UIScene) {
        
        //coreDataService.saveContext()
    }
}
