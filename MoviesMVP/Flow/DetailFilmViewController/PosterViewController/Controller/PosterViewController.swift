//
//  PosterViewController.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 06.05.2021.
//

import UIKit

class PosterViewController: UIViewController {
    var detailFilmInfo: DetailFilmResult? {
        didSet {
            presenter.viewDidOpenFilmInfoVC(with: film)
        }
    }
    private var film: Film
    private let transition = PanelTransition()
    // MARK: View
    private lazy var posterView : PosterView = {
        PosterView()
    }()
    var filmInCollection: Bool = false {
        didSet {
            if  filmInCollection {
                posterView.addAndRemoveFilmButton.setTitle("remove", for: .normal)
                posterView.addAndRemoveFilmButton.backgroundColor = .red
            } else {
                posterView.addAndRemoveFilmButton.setTitle("add", for: .normal)
                posterView.addAndRemoveFilmButton.backgroundColor = .green
            }
        }
    }

    private let presenter: DetailViewOutput
    // MARK: - Init
    init(presenter: DetailViewOutput, film: Film) {
        self.film = film
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        self.view = posterView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidRequest(filmId: film.filmID)
        presenter.viewDidRequestIsFilmInDateBase(filmId: film.filmID)
        setupFilmPoster()
        setupActions()
        setupNavigationItems()
    }
    // MARK: - Setup navigation items
    private func setupNavigationItems() {
        navigationItem.title = film.nameRu
    }
    // MARK: - Setup film poster
    private func setupFilmPoster() {
        posterView.configure(with: film.posterURL)
    }
    private func setupActions() {
        posterView.showVCButton.addTarget(self, action: #selector(showButtonTapped),
                                          for: .touchUpInside)
        posterView.addAndRemoveFilmButton.addTarget(self, action: #selector(addAndRemoveFilmButtonTapped),
                                                    for: .touchUpInside)
    }
    @objc private func showButtonTapped() {
        presenter.viewDidOpenFilmInfoVC(with: film)
    }
    @objc private func addAndRemoveFilmButtonTapped() {
        if  filmInCollection {
            presenter.viewDidRequestToDeleteFilm(film: film)
            filmInCollection = false
        } else {
            presenter.viewDidRequestToSaveFilm(film: film)
            filmInCollection = true
        }
    }

}
// MARK: - MainViewInput
extension PosterViewController: DetailViewInput {

}
