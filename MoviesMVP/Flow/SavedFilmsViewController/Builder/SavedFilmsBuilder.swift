//
//  SavedFilmsBuilder.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 08.05.2021.
//

import UIKit

class SavedFilmsBuilder {
    static func build(requestFactory: RequestFactory,
                      coreDataService: CoreDataService) -> (UIViewController & SavedFilmsViewInput) {
        let presenter = SavedFilmsPresenter(requestFactory: requestFactory, coreDataService: coreDataService)
        let viewController = SavedFilmsViewController(presenter: presenter)
        presenter.viewInput = viewController
        return viewController
    }
}
