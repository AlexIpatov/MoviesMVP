//
//  SelfConfiguringCell.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 13.05.2021.
//

import Foundation

protocol SelfConfiguringCell: SelfConfiguringView {
    static var reuseId: String { get }
}
