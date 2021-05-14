//
//  FilmInfoBuilder.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 13.05.2021.
//

import UIKit

class FilmInfoBuilder {
    static func build(coreDataService: CoreDataService,
                      with film: Film, with detailFilm: DetailFilmResult) -> (UIViewController & FilmInfoViewInput) {
        let presenter = FilmInfoViewPresenter(coreDataService: coreDataService)
        let viewController = FilmInfoViewController(film: film,
                                                    detailFilmInfo: detailFilm,
                                                    presenter: presenter)
        presenter.viewInput = viewController
        return viewController
    }
}
