//
//  UILabel+Extension.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 04.05.2021.
//

import UIKit

extension UILabel {
    convenience init(font: UIFont? = .filmTitleFont(),
                     textColor: UIColor = .black,
                     numberOfLines: Int = 0,
                     textAlignment: NSTextAlignment = .center) {
        self.init()
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
