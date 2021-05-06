//
//  PosterViewController.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 06.05.2021.
//

import UIKit

class PosterViewController: UIViewController {

    private var detailFilmInfo: DetailFilmResult? {
        didSet {
            openFilmInfoVC()
        }
    }

    private var film: Film
    private let transition = PanelTransition()

    // MARK: View
    private lazy var posterView : PosterView = {
        PosterView()
    }()

    // MARK: - Init
    init(film: Film) {
        self.film = film
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
        setupFilmPoster()
        DataFetcherService().fetchFilmById(id: String(film.filmID)) { [weak self] (result) in
            self?.detailFilmInfo = result
        }
    }
    private func openFilmInfoVC() {
        guard let detailFilmInfo = detailFilmInfo else { return }
        let child = FilmInfoViewController(film: film, detailFilmInfo: detailFilmInfo)
        child.transitioningDelegate = transition
        child.modalPresentationStyle = .custom
        present(child, animated: true)
    }

    // MARK: - Setup film poster
    private func setupFilmPoster() {
        posterView.configure(with: film.posterURL)
    }
}
