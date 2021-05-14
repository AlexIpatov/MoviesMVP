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

    private let dataFetcherService: DataFetcherService
    private let coreDataService: CoreDataService

    init(dataFetcherService: DataFetcherService,
         coreDataService: CoreDataService) {
        self.coreDataService = coreDataService
        self.dataFetcherService = dataFetcherService
    }

    // MARK: - Open next vc
    private func openFilmDetails(with film: Film) {
        let detailVC = DetailBuilder.build(dataFetcherService: dataFetcherService,
                                           coreDataService: coreDataService,
                                           with: film)
        viewInput?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
// MARK: - Network request
extension SavedFilmsPresenter {
    // MARK: Request 100 popular films
    private func requestData() {
        dataFetcherService.fetchBestFilms( type: .popular) { [weak self] result in
            guard let self = self,
                  let result = result
            else {return}
            self.viewInput?.recommendedFilms = result.films
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
