//
//  GetDetailFilm.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 29.06.2021.
//

import Foundation

class GetDetailFilm {
    let sessionManager: URLSession
    let encoder: ParameterEncoder
    init(
        encoder: ParameterEncoder,
        sessionManager: URLSession) {
        self.encoder = encoder
        self.sessionManager = sessionManager
    }
}

extension GetDetailFilm: AbstractRequestFactory {
    typealias EndPoint = DetailFilmResource
    func request(withCompletion completion:
                    @escaping (Result<EndPoint.ModelType, NetworkingError>) -> Void) {}
}

extension GetDetailFilm: GetDetailFilmFactory {
    func load(filmId: Int, completionHandler: @escaping (Result<DetailFilm, NetworkingError>) -> Void) {
        let route = DetailFilmResource(filmId: filmId)
        request(route, withCompletion: completionHandler)
    }
}
