//
//  UIRefreshControl + Extension.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 04.05.2021.
//

import UIKit

extension UIRefreshControl {
    convenience init(title: String) {
        self.init()
        self.tintColor = .blue
        self.attributedTitle =  NSAttributedString(string: title)
    }
}
