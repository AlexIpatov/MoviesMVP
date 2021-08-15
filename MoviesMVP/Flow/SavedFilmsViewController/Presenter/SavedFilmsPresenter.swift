//
//  SavedFilmsPresenter.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 08.05.2021.
//

import UIKit

protocol SavedFilmsViewInput: AnyObject {
    var savedFilms: [Film] {get set}
    var recommendedFilms: [Film] {get set}
}
protocol SavedFilmsViewOutput: AnyObject {
    func viewDidRequest()
    func viewDidRequestSavedFilms()
    func viewDidRequestDeleteAllFilms()
    func viewDidSelectFilm(_ film: Film)
}
class SavedFilmsPresenter {
    weak var viewInput: (UIViewController & SavedFilmsViewInput)?

    private let requestFactory: RequestFactory
    private let coreDataService: CoreDataService

    init(requestFactory: RequestFactory,
         coreDataService: CoreDataService) {
        self.coreDataService = coreDataService
        self.requestFactory = requestFactory
    }

    // MARK: - Open next vc
    private func openFilmDetails(with film: Film) {
        let detailVC = DetailBuilder.build(requestFactory: requestFactory,
                                           coreDataService: coreDataService,
                                           with: film)
        viewInput?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
// MARK: - Network request
extension SavedFilmsPresenter {
    // MARK: Request 100 popular films
    private func requestData() {
        let bestFilmsRequestFactory = requestFactory.makeGetBestFilmsFactory()
        bestFilmsRequestFactory.load(pageNumber: "1", topType: .popular){ [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let filmsResult):
                self.viewInput?.recommendedFilms = filmsResult.films
            case .failure(let error):
                print(error)
            }
        }
    }
}
// MARK: - CoreData requests
extension SavedFilmsPresenter {
    // MARK: Request saved films
    private func requestSavedFilms() {
        coreDataService.loadFilmsFromCoreData { result in
            self.viewInput?.savedFilms = result
        }
    }
    private func deleteFilms() {
        coreDataService.removeAllFilmsFromCoreData()
    }
}
extension SavedFilmsPresenter: SavedFilmsViewOutput {
    func viewDidRequestDeleteAllFilms() {
        deleteFilms()
    }
    func viewDidRequestSavedFilms() {
        requestSavedFilms()
    }
    func viewDidRequest() {
        requestData()
    }
    func viewDidSelectFilm(_ film: Film) {
        openFilmDetails(with: film)
    }
}
