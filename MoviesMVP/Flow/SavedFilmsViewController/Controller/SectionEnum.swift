//
//  SectionEnum.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 08.05.2021.
//

import Foundation

enum Section: Int, CaseIterable {
    case recommended, myFilms

    func description() -> String {
        switch self {
        case .recommended:
            return "Recommended"
        case .myFilms:
            return "My films"
        }
    }
}
