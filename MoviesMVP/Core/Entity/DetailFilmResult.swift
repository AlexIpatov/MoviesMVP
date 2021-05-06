//
//  DetailFilmResult.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 06.05.2021.
//

import Foundation

struct DetailFilmResult: Codable, Hashable {
    let data: DetailFilm
}
// MARK: - DetailFilm
struct DetailFilm: Codable, Hashable {
    var  dataDescription: String?
    enum CodingKeys: String, CodingKey {
        case dataDescription = "description"
    }
}
