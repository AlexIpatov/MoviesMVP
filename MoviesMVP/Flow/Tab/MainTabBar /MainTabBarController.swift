//
//  MainTabBarController.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 05.05.2021.
//

import UIKit

class MainTabBarController: UITabBarController {

    private var dataFetcherService: DataFetcherService
    // MARK: - Init
    init(dataFetcherService: DataFetcherService) {
        self.dataFetcherService = dataFetcherService
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
        tabBar.tintColor = .red
    }
    // MARK: - Setup
    private func setupControllers() {
        let mainViewController = MainBuilder.build(dataFetcherService: dataFetcherService)

        viewControllers = [
            generateNavigationController(rootViewController: mainViewController,
                                         title: "films",
                                         image: UIImage(systemName: "square.grid.2x2.fill")!,
                                         selectedImage:  UIImage(systemName: "square.grid.2x2.fill")!)
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