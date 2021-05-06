//
//  UIImageView+Extension.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 04.05.2021.
//

import UIKit

extension UIImageView {
    convenience init(placeholderImageName: String) {
        self.init()
        self.contentMode = .scaleAspectFill
        self.image = UIImage(named: placeholderImageName)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
