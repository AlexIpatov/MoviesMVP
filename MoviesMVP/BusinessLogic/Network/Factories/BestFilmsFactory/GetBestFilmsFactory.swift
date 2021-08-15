//
//  GetBestFilmsFactory.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 29.06.2021.
//

import Foundation

protocol GetBestFilmsFactory {
    func load(pageNumber: String,
              topType: TopFilmTypes,
              completionHandler: @escaping (Result<FilmsResult, NetworkingError>) -> Void)
}
