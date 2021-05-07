//
//  SearchFilmResult.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 07.05.2021.
//

import Foundation

struct SearchFilmResult: Codable, Hashable {
    var keyword: String
    let pagesCount: Int
    var films: [Film]
    let searchFilmsCountResult: Int
}
