//
//  FilmInfoView.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 06.05.2021.
//

import UIKit

class FilmInfoView: UIView, SelfConfiguringView {
    // MARK: - Subviews
    private lazy var ratingLabel = UILabel(textColor: .black,
                                           numberOfLines: 1,
                                           textAlignment: .center)
    private lazy var yearLabel = UILabel(textColor: .black,
                                         numberOfLines: 1,
                                         textAlignment: .center)
    private lazy var genresLabel = UILabel(textColor: .black,
                                           numberOfLines: 0,
                                           textAlignment: .center)
    private lazy var countriesLabel = UILabel(textColor: .black,
                                              numberOfLines: 0,
                                              textAlignment: .center)
    private var hideButton: UIButton = {
        let button = UIButton()
        button.setTitle("Hide", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var descriptionTextVeiw = UITextView(text: "", font: .filmInfoDescriptionFont())

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 24
        backgroundColor = .white
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Configure
    func configure<U>(with value: U) where U : Hashable {
        if let film = value as? Film {
            ratingLabel.text = "KP: \(film.rating)"
            yearLabel.text = "\(film.year) year"
            countriesLabel.text = film.countries.compactMap { $0.country }.joined(separator: ", ")
            genresLabel.text = film.genres.compactMap { $0.genre }.joined(separator: ", ")
        } else if let detailFilm = value as? DetailFilmResult {
            descriptionTextVeiw.text = detailFilm.data.dataDescription
        }
    }
    
    // MARK: - Setup constraints
    private func setupConstraints() {
        addSubview(ratingLabel)
        addSubview(yearLabel)
        addSubview(genresLabel)
        addSubview(countriesLabel)
        addSubview(descriptionTextVeiw)
        addSubview(hideButton)
        NSLayoutConstraint.activate([

            yearLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            yearLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            yearLabel.heightAnchor.constraint(equalToConstant: 30),

            ratingLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            ratingLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            ratingLabel.heightAnchor.constraint(equalToConstant: 30),

            countriesLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 5),
            countriesLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            countriesLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            countriesLabel.heightAnchor.constraint(equalToConstant: 40),

            genresLabel.topAnchor.constraint(equalTo: countriesLabel.bottomAnchor, constant: 5),
            genresLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            genresLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            genresLabel.heightAnchor.constraint(equalToConstant: 40),

            descriptionTextVeiw.topAnchor.constraint(equalTo: genresLabel.bottomAnchor, constant: 5),
            descriptionTextVeiw.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            descriptionTextVeiw.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            descriptionTextVeiw.bottomAnchor.constraint(equalTo: hideButton.topAnchor, constant: -5),

            hideButton.heightAnchor.constraint(equalToConstant: 50),
            hideButton.widthAnchor.constraint(equalToConstant: 100),
            hideButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            hideButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)

        ])
    }
}
