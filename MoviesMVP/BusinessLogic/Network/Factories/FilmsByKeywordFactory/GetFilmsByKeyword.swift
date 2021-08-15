//
//  FilmsByKeyword.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 29.06.2021.
//

import Foundation

class GetFilmsByKeyword {
    let sessionManager: URLSession
    let encoder: ParameterEncoder
    init(
        encoder: ParameterEncoder,
        sessionManager: URLSession) {
        self.encoder = encoder
        self.sessionManager = sessionManager
    }
}

extension GetFilmsByKeyword: AbstractRequestFactory {
    typealias EndPoint = FilmsByKeywordResource
    func request(withCompletion completion:
                    @escaping (Result<EndPoint.ModelType, NetworkingError>) -> Void) {}
}

extension GetFilmsByKeyword: GetFilmsByKeywordFactory {
    func load(keyword: String, pageNumber: String, completionHandler: @escaping (Result<SearchFilmResult, NetworkingError>) -> Void) {
        let route = FilmsByKeywordResource(keyword: keyword, pageNumber: pageNumber)
        request(route, withCompletion: completionHandler)
    }
}
