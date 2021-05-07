//
//  MainBuilder.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 04.05.2021.
//

import UIKit

class MainBuilder {
    static func build(dataFetcherService: DataFetcherService) -> (UIViewController & MainViewInput) {
        let presenter = MainPresenter(dataFetcherService: dataFetcherService)
        let viewController = MainViewController(presenter: presenter)
        presenter.viewInput = viewController
        return viewController
    }
}
