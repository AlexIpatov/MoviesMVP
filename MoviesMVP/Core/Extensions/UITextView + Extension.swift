//
//  UITextView + Extension.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 06.05.2021.
//

import UIKit

extension UITextView {
    convenience init(text: String,
                     font: UIFont? = .filmInfoDescriptionFont(),
                     textColor: UIColor = .black,
                     textAlignment: NSTextAlignment = .left,
                     isEditable: Bool = false
                     ) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.isEditable = isEditable
        self.isSelectable = false
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
