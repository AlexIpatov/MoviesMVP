//
//  FilmInfoViewController.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 06.05.2021.
//

import UIKit

class FilmInfoViewController: UIViewController {

    private var film: Film
    private var detailFilmInfo: DetailFilmResult
    // MARK: View
    private lazy var filmInfoView: FilmInfoView = {
        FilmInfoView()
    }()

    // MARK: - Init
    init(film: Film, detailFilmInfo: DetailFilmResult) {
        self.film = film
        self.detailFilmInfo = detailFilmInfo
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        self.view = filmInfoView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFilmViews()
        setupActions()
    }

    // MARK: - Setup film views
    private func setupFilmViews() {
        filmInfoView.configure(with: film)
        filmInfoView.configure(with: detailFilmInfo)
    }

    private func setupActions() {
        filmInfoView.hideButton.addTarget(self, action: #selector(hideVC), for: .touchUpInside)
    }

    @objc private func hideVC() {
        dismiss(animated: true, completion: nil)
    }

}
