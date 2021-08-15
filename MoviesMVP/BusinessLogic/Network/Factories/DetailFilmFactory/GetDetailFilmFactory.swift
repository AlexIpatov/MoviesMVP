//
//  GetDetailFilmFactory.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 29.06.2021.
//

import Foundation

protocol GetDetailFilmFactory {
    func load(filmId: Int,
              completionHandler: @escaping (Result<DetailFilm, NetworkingError>) -> Void)
}
