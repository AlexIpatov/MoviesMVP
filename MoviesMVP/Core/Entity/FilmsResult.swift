//
//  Film.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 04.05.2021.
//

import Foundation

struct FilmsResult: Codable, Hashable {
    let pagesCount: Int
    var films: [Film]
}
// MARK: - Film
struct Film: Codable, Hashable {
    var filmID: Int
    let nameRu: String?
    let year: String?
    let rating: String?
    let posterURLPreview: String
    enum CodingKeys: String, CodingKey {
        case filmID = "filmId"
        case nameRu, year, rating
        case posterURLPreview = "posterUrlPreview"
    }
}
// MARK: - Country
struct Country: Codable, Hashable {
    let country: String
}
// MARK: - Genre
struct Genre: Codable, Hashable {
    let genre: String
}
