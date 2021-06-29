//
//  EndPointType.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 29.06.2021.
//

import Foundation

protocol EndPointType {
    associatedtype ModelType: Decodable
    var host      : BaseURL    { get }
    var path      : Path       { get }
    var httpMethod: HTTPMethod { get }
    var parameters: Parameters { get }
    var queryItems: [URLQueryItem]? { get }
}
extension EndPointType {
    func url() -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host.baseURL
        components.path = path.path
        components.queryItems = queryItems
        guard let url = components.url else { return nil }
        return url
    }
}
enum BaseURL {
    case kinopoisk
}
extension BaseURL {
    var baseURL: String {
        switch self {
        case .kinopoisk:
            return "kinopoiskapiunofficial.tech"
        }
    }
}
enum Path {
    case bestFilms
    case detailFilm
    case searchByKeyword
}
extension Path {
    var path: String {
        switch self {
        case .bestFilms:
            return "/api/v2.2/films/top"
        case .detailFilm:
            return "/api/v2.1/films/"
        case .searchByKeyword:
            return "/api/v2.1/films/search-by-keyword"
        }
    }
}
enum ApiKey {
    case developKey
}
extension ApiKey {
    var apiKey: String {
        switch self {
        case .developKey:
            return "a96707e0-89e5-41ef-a7c4-1d6159ddb688"
        }
    }
}
