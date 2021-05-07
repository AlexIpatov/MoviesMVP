//
//  UIButton + Extension.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 06.05.2021.
//

import UIKit

extension UIButton {
    convenience init(title: String? = nil,
                     image: UIImage? = nil,
                     cornerRadius: CGFloat,
                     backgroundColor: UIColor = UIColor.white.withAlphaComponent(0.4),
                     tintColor: UIColor = .white) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
        self.setImage(image, for: .normal)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.translatesAutoresizingMaskIntoConstraints = false
        self.tintColor = tintColor

        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
}
