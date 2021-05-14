//
//  SectionFooter.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 14.05.2021.
//

import UIKit

class SectionFooter: UICollectionReusableView {

    static let reuseId = "SectionFooter"

    let deleteAllButton = UIButton(title: "Delete all saved movies",
                                   image: UIImage(systemName: "trash"),
                                   cornerRadius: 0,
                                   backgroundColor: .clear,
                                   tintColor: .black)
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupConstraints() {
      addSubview(deleteAllButton)
        NSLayoutConstraint.activate([
            deleteAllButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            deleteAllButton.heightAnchor.constraint(equalToConstant: 30),
            deleteAllButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
