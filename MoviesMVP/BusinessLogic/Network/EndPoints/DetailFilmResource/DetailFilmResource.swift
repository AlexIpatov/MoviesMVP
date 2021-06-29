//
//  DetailFilmResource.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 29.06.2021.
//

import Foundation

struct DetailFilmResource: EndPointType {
    var queryItems: [URLQueryItem]?
    var filmId: Int
    typealias ModelType = DetailFilm
    var host: BaseURL = .kinopoisk
    var path: Path = .detailFilm
    var httpMethod: HTTPMethod = .get
    var parameters: Parameters {
        ["filmId": filmId]
    }
}
