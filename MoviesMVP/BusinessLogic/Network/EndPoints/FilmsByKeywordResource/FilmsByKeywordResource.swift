//
//  FilmsByKeywordResource.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 29.06.2021.
//

import Foundation

struct FilmsByKeywordResource: EndPointType {
    typealias ModelType = SearchFilmResult
    var host: BaseURL = .kinopoisk
    var path: Path = .searchByKeyword
    var httpMethod: HTTPMethod = .get
    var keyword: String
    var pageNumber: String
    var parameters: Parameters = [:]
    var queryItems: [URLQueryItem]? {
        [ URLQueryItem(name: "keyword", value: keyword),
          URLQueryItem(name: "page", value: pageNumber)]
    }
}
