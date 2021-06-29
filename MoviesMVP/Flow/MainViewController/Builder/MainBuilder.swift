//
//  MainBuilder.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 04.05.2021.
//

import UIKit

class MainBuilder {
    static func build(requestFactory: RequestFactory,
                      coreDataService: CoreDataService) -> (UIViewController & MainViewInput) {
        let presenter = MainPresenter(requestFactory: requestFactory, coreDataService: coreDataService)
        let viewController = MainViewController(presenter: presenter)
        presenter.viewInput = viewController
        return viewController
    }
}
