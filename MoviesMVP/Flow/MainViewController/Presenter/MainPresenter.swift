//
//  MainPresenter.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 04.05.2021.
//

import UIKit

protocol MainViewInput: AnyObject {
    var results: [Film] {get set}
    var searchResults: [Film] {get set}
}
protocol MainViewOutput: AnyObject {
    func viewDidRequestBestFilms()
    func viewDidRequestFilmsByKeyword(keyword: String?)
    func viewDidSelectFilm(_ film: Film)
}
class MainPresenter {
    private var currentPage: Int = 1
    private var maxPageCount: Int = 2

    private var currentPageForSearch: Int = 1
    private var maxPageCountForSearch: Int = 2
    weak var viewInput: (UIViewController & MainViewInput)?

    private let requestFactory: RequestFactory
    private let coreDataService: CoreDataService

    init(requestFactory: RequestFactory, coreDataService: CoreDataService) {
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
// MARK: - Network requests
extension MainPresenter {
    // MARK: Request films by keyword
    private func requestFilmsByKeyword(keyword: String?) {
        guard let keyword = keyword, keyword != "" else {
            return
        }
        let filmsByKeywordFactory = requestFactory.makeGetFilmsByKeywordFactory()
        filmsByKeywordFactory.load(keyword: keyword,
                                   pageNumber: String(currentPage)) {[weak self] result in
            guard let self = self,
                  self.currentPage <= self.maxPageCount
            else {return}

            switch result {
            case .success(let filmResult):
                self.viewInput?.searchResults += filmResult.films
                self.maxPageCountForSearch = filmResult.pagesCount
                self.currentPage += 1
            case .failure(let error):
                print(error)
            }
        }
    }
    // MARK: Request best 250 films
    private func requestData() {
        let bestFilmsRequestFactory = requestFactory.makeGetBestFilmsFactory()
        bestFilmsRequestFactory.load(pageNumber: String(currentPage),
                                     topType: .best) { [weak self] result in
            guard let self = self,
                  self.currentPage <= self.maxPageCount
            else {return}

            switch result {
            case .success(let filmResult):
                self.maxPageCount = filmResult.pagesCount
                self.viewInput?.results += filmResult.films
                self.currentPage += 1
            case .failure(let error):
                print(error)
            }
        }
    }
}
extension MainPresenter: MainViewOutput {
    func viewDidRequestBestFilms() {
        requestData()
    }
    func viewDidRequestFilmsByKeyword(keyword: String?) {
        requestFilmsByKeyword(keyword: keyword)
    }
    func viewDidSelectFilm(_ film: Film) {
        openFilmDetails(with: film)
    }
}
