//
//  DetailViewPresenter.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 06.05.2021.
//

import UIKit

protocol DetailViewInput: AnyObject {
    var detailFilmInfo: DetailFilmResult? {get set}
}
protocol DetailViewOutput: AnyObject {
    func viewDidRequest(filmId: Int)
    func viewDidOpenFilmInfoVC(with film: Film)
}
class DetailViewPresenter {
    weak var viewInput: (PosterViewController & DetailViewInput)?

    private let transition = PanelTransition()

    private let dataFetcherService: DataFetcherService
    private let coreDataService: CoreDataService

    init(dataFetcherService: DataFetcherService,
         coreDataService: CoreDataService) {
        self.coreDataService = coreDataService
        self.dataFetcherService = dataFetcherService
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
        let child = FilmInfoBuilder.build(coreDataService: coreDataService,
                                          with: film,
                                          with: detailFilmInfo)
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
}
