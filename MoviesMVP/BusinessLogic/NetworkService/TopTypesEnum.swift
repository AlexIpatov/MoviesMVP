//
//  TopTypesEnum.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 08.05.2021.
//

import Foundation

enum TopFilmTypes {
    case best, popular, await

    func description() -> String {
        switch self {
        case .best:
            return "TOP_250_BEST_FILMS"
        case .popular:
            return "TOP_100_POPULAR_FILMS"
        case .await:
            return "TOP_AWAIT_FILMS"
        }
    }
}
