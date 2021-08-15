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

    private let requestFactory: RequestFactory
    private let coreDataService: CoreDataService

    init(requestFactory: RequestFactory,
         coreDataService: CoreDataService) {
        self.coreDataService = coreDataService
        self.requestFactory = requestFactory
    }
    // MARK: - requestData
    private func requestData(filmId: Int) {
//       let detailFactory = requestFactory.makeGetDetailFilmFactory()
//        detailFactory.load(filmId: filmId) { [weak self] result in
//            guard let self = self else {return}
//            switch result {
//            case .success(let filmResult):
//                self.viewInput?.detailFilmInfo = filmResult
//            case .failure(_):
//                <#code#>
//            }
//        }
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
