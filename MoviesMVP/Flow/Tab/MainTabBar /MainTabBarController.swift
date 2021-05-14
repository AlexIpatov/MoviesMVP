//
//  MainTabBarController.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 05.05.2021.
//

import UIKit

final class MainTabBarController: UITabBarController {
    // MARK: - Properties
    private let dataFetcherService: DataFetcherService
    private let coreDataService: CoreDataService
    // MARK: - Init
    init(dataFetcherService: DataFetcherService, coreDataService: CoreDataService) {
        self.dataFetcherService = dataFetcherService
        self.coreDataService = coreDataService
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
        tabBar.tintColor = .blue
    }
    // MARK: - Setup
    private func setupControllers() {
        let mainViewController = MainBuilder.build(dataFetcherService: dataFetcherService,
                                                   coreDataService: coreDataService)
        let savedFilmsViewController = SavedFilmsBuilder.build(dataFetcherService: dataFetcherService,
                                                               coreDataService: coreDataService)
        viewControllers = [
            generateNavigationController(rootViewController: mainViewController,
                                         title: "Search",
                                         image: UIImage(systemName: "magnifyingglass.circle")!,
                                         selectedImage: UIImage(systemName: "magnifyingglass.circle.fill")!),

            generateNavigationController(rootViewController: savedFilmsViewController,
                                         title: "My films",
                                         image:  UIImage(systemName: "ticket")!,
                                         selectedImage: UIImage(systemName: "ticket.fill")!)
        ]
    }
    private func generateNavigationController(rootViewController: UIViewController,
                                              title: String, image: UIImage, selectedImage: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.selectedImage = selectedImage
        navigationVC.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        return navigationVC
    }
}
