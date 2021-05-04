//
//  SelfConfiguringCell.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 18.03.2021.

import Foundation

protocol SelfConfiguringCell {
    static var reuseId: String { get }
    func configure<U: Hashable>(with value: U)
}
