//
//  FilmInfoViewPresenter.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 13.05.2021.
//

import UIKit

protocol FilmInfoViewInput: AnyObject {
    var filmInCollection: Bool {get set}
}
protocol FilmInfoViewOutput: AnyObject {
    func viewDidSelectHideButton()
    func viewDidRequestToSaveFilm(film: Film)
    func viewDidRequestToDeleteFilm(film: Film)
    func viewDidRequestIsFilmInDateBase(filmId: Int)
}
class FilmInfoViewPresenter {
    weak var viewInput: (FilmInfoViewController & FilmInfoViewInput)?

    private let coreDataService: CoreDataService

    init(coreDataService: CoreDataService) {
        self.coreDataService = coreDataService
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
        viewInput?.filmInCollection = true
    }
    // MARK: - remove from CoreData
    private func removeFilmFromCoreData(film: Film) {
        coreDataService.removeFilm(film: film)
        viewInput?.filmInCollection = false
    }
    // MARK: - Dismiss VC
    private func dismissVC() {
        viewInput?.dismiss(animated: true, completion: nil)
    }
}
extension FilmInfoViewPresenter: FilmInfoViewOutput {
    func viewDidRequestToSaveFilm(film: Film) {
        saveFilmToCoreData(film: film)
    }
    func viewDidRequestToDeleteFilm(film: Film) {
        removeFilmFromCoreData(film: film)
    }
    func viewDidRequestIsFilmInDateBase(filmId: Int) {
        filmIsInDatabase(with: filmId)
    }
    func viewDidSelectHideButton() {
        dismissVC()
    }
}
