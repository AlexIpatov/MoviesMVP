//
//  Film.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 04.05.2021.
//

import Foundation

// MARK: - CategoriesResult
struct FilmsResult: Codable {
    let pagesCount: Int
    let films: [Film]
}

// MARK: - Film
struct Film: Codable {
    let filmID: Int
    let nameRu: String
    let nameEn: String?
    let year, filmLength: String
    let countries: [Country]
    let genres: [Genre]
    let rating: String
    let ratingVoteCount: Int
    let posterURL, posterURLPreview: String

    enum CodingKeys: String, CodingKey {
        case filmID = "filmId"
        case nameRu, nameEn, year, filmLength, countries, genres, rating, ratingVoteCount
        case posterURL = "posterUrl"
        case posterURLPreview = "posterUrlPreview"
    }
}

// MARK: - Country
struct Country: Codable {
    let country: String
}

// MARK: - Genre
struct Genre: Codable {
    let genre: String
}

