//
//  AppStertManager.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 29.06.2021.
//

import UIKit

final class AppStartManager {
    private var window: UIWindow?
    private let requestFactory = RequestFactory()
    private let coreDataService = CoreDataService()

    private lazy var rootViewController = {
        MainTabBarController(requestFactory: requestFactory,
                             coreDataService: coreDataService)
    }()
    init(window: UIWindow?) {
        self.window = window
    }
    func start() {
        let navVC = UINavigationController(rootViewController: rootViewController)

        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
}

