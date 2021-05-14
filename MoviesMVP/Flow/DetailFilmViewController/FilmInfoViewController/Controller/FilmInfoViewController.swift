//
//  FilmInfoViewController.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 06.05.2021.
//

import UIKit

class FilmInfoViewController: UIViewController, FilmInfoViewInput {
    // MARK: - Properties
    var filmInCollection: Bool = false {
        didSet {
            setupSaveAndDeleteButton()
        }
    }
    private let presenter: FilmInfoViewOutput
    private var film: Film
    private var detailFilmInfo: DetailFilmResult
    // MARK: View
    private lazy var filmInfoView: FilmInfoView = {
        FilmInfoView()
    }()
    // MARK: - Init
    init(film: Film,
         detailFilmInfo: DetailFilmResult,
         presenter: FilmInfoViewOutput) {
        self.film = film
        self.detailFilmInfo = detailFilmInfo
        self.presenter = presenter
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
        setupSaveAndDeleteButton()
        presenter.viewDidRequestIsFilmInDateBase(filmId: film.filmID)
    }
    // MARK: - Setup film views
    private func setupFilmViews() {
        filmInfoView.configure(with: film)
        filmInfoView.configure(with: detailFilmInfo)
    }
    private func setupSaveAndDeleteButton() {
        switch filmInCollection {
        case true:
            filmInfoView.saveAndDeleteButton.setImage(UIImage(systemName: "heart.fill"),
                                                      for: .normal)
        case false:
            filmInfoView.saveAndDeleteButton.setImage(UIImage(systemName: "heart"),
                                                      for: .normal)
        }
    }
    // MARK: - Setup actions
    private func setupActions() {
        filmInfoView.hideButton.addTarget(self, action: #selector(hideButtonTapped),
                                          for: .touchUpInside)
        filmInfoView.saveAndDeleteButton.addTarget(self, action: #selector(saveAndDeleteButtonTapped),
                                                   for: .touchUpInside)
    }
    @objc private func hideButtonTapped() {
        presenter.viewDidSelectHideButton()
    }
    @objc private func saveAndDeleteButtonTapped() {
        switch filmInCollection {
        case true:
            presenter.viewDidRequestToDeleteFilm(film: film)
        case false:
            presenter.viewDidRequestToSaveFilm(film: film)
        }
    }
}
