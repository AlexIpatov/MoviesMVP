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
    let filmID: Int
    let nameRu: String
    let nameEn: String?
    let year, filmLength: String?
    let countries: [Country]
    let genres: [Genre]
    let rating: String?
    let posterURL, posterURLPreview: String
    var detailFilmResult: DetailFilm?
    enum CodingKeys: String, CodingKey {
        case detailFilmResult = "data"
        case filmID = "filmId"
        case nameRu, nameEn, year, filmLength, countries, genres, rating
        case posterURL = "posterUrl"
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
