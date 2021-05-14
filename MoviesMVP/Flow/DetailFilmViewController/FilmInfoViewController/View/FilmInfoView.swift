//
//  FilmInfoView.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 06.05.2021.
//

import UIKit

class FilmInfoView: UIView, SelfConfiguringView {
    // MARK: - Subviews
    private lazy var ratingLabel = UILabel(font: .filmInfoDescriptionFont(),
                                           textColor: .black,
                                           numberOfLines: 1,
                                           textAlignment: .center)
    private lazy var yearLabel = UILabel(font: .filmInfoDescriptionFont(),
                                         textColor: .black,
                                         numberOfLines: 1,
                                         textAlignment: .center)
    private lazy var genresLabel = UILabel(font: .filmInfoDescriptionFont(),
                                           textColor: .black,
                                           numberOfLines: 0,
                                           textAlignment: .center)
    private lazy var countriesLabel = UILabel(font: .filmInfoDescriptionFont(),
                                              textColor: .black,
                                              numberOfLines: 0,
                                              textAlignment: .center)
    let hideButton: UIButton = {
        let button = UIButton()
        button.setTitle("Hide", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let saveAndDeleteButton = UIButton(image: UIImage(systemName: "heart"),
                                       cornerRadius: 25,
                                       tintColor: .red)
    private lazy var descriptionTextVeiw = UITextView(text: "", font: .filmInfoDescriptionFont())

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
            ratingLabel.text = "KP: \(film.rating ?? "-")"
            yearLabel.text = film.year
        } else if let detailFilm = value as? DetailFilmResult {
            countriesLabel.text = detailFilm.data.countries?.compactMap { $0.country }.joined(separator: ", ")
            genresLabel.text = detailFilm.data.genres?.compactMap { $0.genre }.joined(separator: ", ")
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
        addSubview(saveAndDeleteButton)
        NSLayoutConstraint.activate([
            saveAndDeleteButton.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            saveAndDeleteButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            saveAndDeleteButton.widthAnchor.constraint(equalToConstant: 50),
            saveAndDeleteButton.heightAnchor.constraint(equalTo: saveAndDeleteButton.widthAnchor),

            yearLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            yearLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            yearLabel.heightAnchor.constraint(equalToConstant: 30),

            ratingLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 5),
            ratingLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
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
