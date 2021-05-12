//
//  DetailViewPresenter.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 06.05.2021.
//

import UIKit

protocol DetailViewInput: AnyObject {
    var detailFilmInfo: DetailFilmResult? {get set}
    var filmInCollection: Bool {get set}
}
protocol DetailViewOutput: AnyObject {
    func viewDidRequest(filmId: Int)
    func viewDidOpenFilmInfoVC(with film: Film)
    func viewDidRequestToSaveFilm(film: Film)
    func viewDidRequestToDeleteFilm(film: Film)
    func viewDidRequestIsFilmInDateBase(filmId: Int)
}
class DetailViewPresenter {
    weak var viewInput: (PosterViewController & DetailViewInput)?

    private let transition = PanelTransition()

    private let dataFetcherService: DataFetcherService
    private let coreDataService: CoreDataService

    init(dataFetcherService: DataFetcherService, coreDataService: CoreDataService) {
        self.coreDataService = coreDataService
        self.dataFetcherService = dataFetcherService
    }
    // MARK: - Сhecking if a movie is in the database
    private func filmIsInDatabase(with filmID: Int) {
        if coreDataService.filmInCoreData(filmId: filmID) {
            viewInput?.filmInCollection = true
        } else {
            viewInput?.filmInCollection = false
        }
    }
    // MARK: - save to CoreData
    private func saveFilmToCoreData(film: Film) {
        coreDataService.saveFilmToCoreData(film: film)
    }
    // MARK: - remove from CoreData
    private func removeFilmFromCoreData(film: Film) {
        coreDataService.removeFilm(film: film)
    }
    // MARK: - requestData
    private func requestData(filmId: Int) {
        dataFetcherService.fetchFilmById(id: String(filmId)) { [weak self] result in
            guard let self = self,
                  let result = result
            else {return}
            self.viewInput?.detailFilmInfo = result
        }
    }
    // MARK: - Open child VC
    private func openFilmInfoVC(with film: Film) {
        guard let detailFilmInfo = viewInput?.detailFilmInfo
        else { return }
        let child = FilmInfoViewController(film: film, detailFilmInfo: detailFilmInfo)
        child.transitioningDelegate = transition
        child.modalPresentationStyle = .custom
        viewInput?.present(child, animated: true)
    }
}
extension DetailViewPresenter: DetailViewOutput {
    func viewDidOpenFilmInfoVC(with film: Film) {
        openFilmInfoVC(with: film)
    }
    func viewDidRequest(filmId: Int) {
        requestData(filmId: filmId)
    }
    func viewDidRequestToSaveFilm(film: Film) {
        saveFilmToCoreData(film: film)
    }
    func viewDidRequestToDeleteFilm(film: Film) {
        removeFilmFromCoreData(film: film)
    }
    func viewDidRequestIsFilmInDateBase(filmId: Int) {
        filmIsInDatabase(with: filmId)
    }
}
