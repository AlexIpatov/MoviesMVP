//
//  DetailBuilder.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 06.05.2021.
//

import UIKit

class DetailBuilder {
    static func build(dataFetcherService: DataFetcherService, coreDataService: CoreDataService,
                      with film: Film) -> (UIViewController & DetailViewInput) {
        let presenter = DetailViewPresenter(dataFetcherService: dataFetcherService, coreDataService: coreDataService)
        let viewController = PosterViewController(presenter: presenter, film: film)
        presenter.viewInput = viewController
        return viewController
    }
}
