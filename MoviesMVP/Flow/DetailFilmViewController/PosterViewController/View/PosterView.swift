//
//  PosterView.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 06.05.2021.
//

import UIKit
import Kingfisher

class PosterView: UIView, SelfConfiguringView {
    // MARK: - Subviews
    private lazy var posterView = UIImageView(placeholderImageName: "")
    let showVCButton = UIButton(title: "show info",
                                cornerRadius: 0,
                                backgroundColor: .blue)
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .brown
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Configure
    func configure<U>(with value: U) where U : Hashable {
        guard let posterURL = value as? String else { return }
        posterView.kf.setImage(with: URL(string: posterURL))
    }
    // MARK: - Setup constraints
    private func setupConstraints() {
        addSubview(posterView)
        addSubview(showVCButton)
        NSLayoutConstraint.activate([
            posterView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            posterView.leftAnchor.constraint(equalTo: leftAnchor),
            posterView.rightAnchor.constraint(equalTo: rightAnchor),
            posterView.bottomAnchor.constraint(equalTo: showVCButton.topAnchor),

            showVCButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            showVCButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            showVCButton.widthAnchor.constraint(equalTo: widthAnchor),
            showVCButton.heightAnchor.constraint(equalToConstant: 40)

        ])
    }
}
