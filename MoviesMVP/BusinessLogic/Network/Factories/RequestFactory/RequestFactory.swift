//
//  RequestFactory.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 29.06.2021.
//

import Foundation

final class RequestFactory {

    private let commonSession: URLSession

    init(commonSession: URLSession = URLSession.shared) {
        self.commonSession = commonSession
    }

    // MARK: - kinopoisk api methods:

    func makeGetFilmsByKeywordFactory() -> GetFilmsByKeywordFactory {
        let encoder = URLPathParameterEncoder()
        return GetFilmsByKeyword(encoder: encoder,
                                 sessionManager: commonSession)
    }

    func makeGetBestFilmsFactory() -> GetBestFilmsFactory {
        let encoder = URLPathParameterEncoder()
        return GetBestFilms(encoder: encoder,
                           sessionManager: commonSession)
    }

    func makeGetDetailFilmFactory() -> GetDetailFilmFactory {
        let encoder = URLPathParameterEncoder()
        return GetDetailFilm(encoder: encoder,
                           sessionManager: commonSession)
    }
}

