//
//  RecommendedFilmCell.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 08.05.2021.
//

import UIKit
import Kingfisher

class RecommendedFilmCell: UICollectionViewCell, SelfConfiguringView {

    static var reuseId: String = "RecommendedFilmCell"

    // MARK: - Subviews
    private var ratingLabel = UILabel(font: .filmYearRatingFont(),
                                      textColor: .black,
                                      numberOfLines: 1,
                                      textAlignment: .center)
    private var posterImageView = UIImageView(placeholderImageName: "")
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupLayer()
    }
    private func setupLayer() {
        backgroundColor = .white
    }
    func configure<U>(with value: U) where U : Hashable {
        guard let film: Film = value as? Film else { return }
        ratingLabel.text = "KP: \(film.rating ?? "-")"
        posterImageView.kf.setImage(with: URL(string: film.posterURLPreview))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: - Setup constraints
    private func setupConstraints() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(ratingLabel)
        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -5),
            ratingLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            ratingLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),

            posterImageView.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor),
            posterImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            posterImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9),
            posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor, multiplier: 0.7),
        ])
    }
}
