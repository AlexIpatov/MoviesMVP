//
//  BestFilmsResource.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 29.06.2021.
//

import Foundation

struct BestFilmsResource: EndPointType {
    typealias ModelType = FilmsResult
    var host: BaseURL = .kinopoisk
    var path: Path = .bestFilms
    var httpMethod: HTTPMethod = .get
    var type: TopFilmTypes
    var pageNumber: String = "1"
    var parameters: Parameters = [:]
    var queryItems: [URLQueryItem]? {
        [   URLQueryItem(name: "page", value: pageNumber),
            URLQueryItem(name: "type", value: type.description()) ]
    }
}
