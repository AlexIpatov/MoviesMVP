//
//  UIView + Extension.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 14.05.2021.
//

import UIKit

extension UIView {
    func colorFromRating(rating: String?) -> UIColor {
        guard let rating = rating,
              let ratingDouble = Double(rating) else {return .black}
        if (0.0...5.0).contains(ratingDouble) {
            return .redRatingColor()
        } else if (5.0...7.0).contains(ratingDouble) {
            return .yellowRatingColor()
        } else if (7.0...10.0).contains(ratingDouble) {
            return .greenRatingColor()
        } else {
            return .black
        }
    }
}
