//
//  SavedFilmCell.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 08.05.2021.
//

import UIKit

class SavedFilmCell: UICollectionViewCell, SelfConfiguringCell {

    // MARK: Cell ID
    static var reuseId: String = "SavedFilmCell"

    // MARK: - Subviews
    private var titleLabel = UILabel(textColor: .black,
                                     numberOfLines: 2,
                                     textAlignment: .left)

    private var yearLabel = UILabel(font: .filmYearRatingFont(),
                                    textColor: .black,
                                    numberOfLines: 1,
                                    textAlignment: .right)

    private var ratingLabel = UILabel(font: .filmYearRatingFont(),
                                      textColor: .black,
                                      numberOfLines: 1,
                                      textAlignment: .right)
    private var posterImageView = UIImageView(placeholderImageName: "")

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLayer()
        setupConstraints()
    }
    func configure<U>(with value: U) where U : Hashable {
        guard let film: Film = value as? Film else { return }
        titleLabel.text = film.nameRu
        yearLabel.text = "year: \(film.year ?? "-")"
        ratingLabel.textColor = self.colorFromRating(rating: film.rating)
        ratingLabel.text = "rating: \(film.rating ?? "-")"
        posterImageView.kf.setImage(with: URL(string: film.posterURLPreview))
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup UI
    private func setupLayer() {
        backgroundColor = .white
        layer.borderWidth = 0.2
        layer.borderColor = UIColor.systemGray.cgColor
    }
    private func setupConstraints() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(yearLabel)
        contentView.addSubview(ratingLabel)
       contentView.addSubview(posterImageView)
        NSLayoutConstraint.activate([
            posterImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            posterImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            posterImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9),
            posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor, multiplier: 0.7),

            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 5),
            titleLabel.rightAnchor.constraint(equalTo: ratingLabel.leftAnchor, constant: 5),

            ratingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            ratingLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            ratingLabel.widthAnchor.constraint(equalToConstant: 100),

            yearLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            yearLabel.rightAnchor.constraint(equalTo: ratingLabel.rightAnchor),
            yearLabel.widthAnchor.constraint(equalTo: ratingLabel.widthAnchor)
        ])
    }
}
