//
//  DataFetcherService.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 16.04.2021.
//

import Foundation

class DataFetcherService {
    private(set) lazy var urlConstructor: URLComponents = {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "kinopoiskapiunofficial.tech"
        return urlComponents
    }()
    private let headers: [String: String] = ["X-API-KEY": "a96707e0-89e5-41ef-a7c4-1d6159ddb688"]

    var networkDataFetcher: DataFetcher

    init(networkDataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.networkDataFetcher = networkDataFetcher
    }
    func fetchBestFilms(pageNumber: String = "1", completion: @escaping (FilmsResult?) -> Void) {
        urlConstructor.path = "/api/v2.2/films/top"
        urlConstructor.queryItems = [
            URLQueryItem(name: "type", value: "TOP_250_BEST_FILMS"),
            URLQueryItem(name: "page", value: pageNumber)
        ]
        guard let url = urlConstructor.url else { return }

        networkDataFetcher.fetchGenericJSONData(url: url, headers: headers, response: completion)
    }
    func fetchFilmById(id: String, completion: @escaping (DetailFilmResult?) -> Void) {
        urlConstructor.path = "/api/v2.1/films/\(id)"
        guard let url = urlConstructor.url else { return }
        networkDataFetcher.fetchGenericJSONData(url: url, headers: headers, response: completion)
    }
}
