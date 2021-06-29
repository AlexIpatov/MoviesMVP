//
//  GetBestFilms.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 29.06.2021.
//

import Foundation

class GetBestFilms {
    let sessionManager: URLSession
    let encoder: ParameterEncoder
    init(
        encoder: ParameterEncoder,
        sessionManager: URLSession) {
        self.encoder = encoder
        self.sessionManager = sessionManager
    }
}

extension GetBestFilms: AbstractRequestFactory {
    typealias EndPoint = BestFilmsResource
    func request(withCompletion completion:
                    @escaping (Result<EndPoint.ModelType, NetworkingError>) -> Void) {}
}

extension GetBestFilms: GetBestFilmsFactory {
    func load(pageNumber: String,
              topType: TopFilmTypes,
              completionHandler: @escaping (Result<FilmsResult, NetworkingError>) -> Void) {
        let route = BestFilmsResource(type: topType, pageNumber: pageNumber)
        request(route, withCompletion: completionHandler)
    }
}
