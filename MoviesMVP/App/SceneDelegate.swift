//
//  SceneDelegate.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 04.05.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var dataFetcherService: DataFetcherService?
    var dataFetcher = NetworkDataFetcher()
    var coreDataService = CoreDataService()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.overrideUserInterfaceStyle = .light
        window?.windowScene = windowScene
        dataFetcherService = DataFetcherService(networkDataFetcher: dataFetcher)
        guard let dataFetcherService = dataFetcherService else {
            return
        }
        window?.rootViewController =  MainTabBarController(dataFetcherService: dataFetcherService,
                                                           coreDataService: coreDataService)
        window?.makeKeyAndVisible()
    }
    func sceneDidEnterBackground(_ scene: UIScene) {
        coreDataService.saveContext()
    }
}
