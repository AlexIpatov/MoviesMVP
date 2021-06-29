//
//  GetFilmsByKeywordFactory.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 29.06.2021.
//

import Foundation

protocol GetFilmsByKeywordFactory {
    func load(keyword: String,
              pageNumber: String,
              completionHandler: @escaping (Result<SearchFilmResult, NetworkingError>) -> Void)
}
