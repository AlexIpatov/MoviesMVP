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
    func viewDidRequest()
    func viewDidRequestMoreFilms()
    func viewDidRequestMoreFilmsByCurrentKeyword()
    func viewDidRequestFilmsByKeyword(keyword: String)
    func viewDidSelectFilm(_ film: Film)
}
class MainPresenter {
    private var currentKeyword: String?
    private var currentPage: Int = 2
    private var maxPageCount: Int = 0
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
    private func requestFilmsByKeyword(keyword: String) {
        let filmsByKeywordFactory = requestFactory.makeGetFilmsByKeywordFactory()
        filmsByKeywordFactory.load(keyword: keyword, pageNumber: "1") {[weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let filmResult):
                self.viewInput?.searchResults = filmResult.films
                self.maxPageCount = filmResult.pagesCount
                self.currentKeyword = filmResult.keyword
                self.currentPage = 2
            case .failure(let error):
                print(error)
            }
        }
    }
//    private func requestMoreFilmsByCurrentKeyword() {
//        dataFetcherService.searchFilmByKeyword(keyword: currentKeyword ?? "",
//                                               pageNumber: String(currentPage)) { [weak self] result in
//            guard let self = self,
//                  let result = result,
//                  self.currentPage <= self.maxPageCount
//            else {return}
//
//            self.viewInput?.searchResults += result.films
//
//            self.currentPage += 1
//        }
//    }
    // MARK: Request best 250 films
    private func requestData() {
        let bestFilmsRequestFactory = requestFactory.makeGetBestFilmsFactory()
        bestFilmsRequestFactory.load(pageNumber: "1", topType: .best) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let filmResult):
            self.viewInput?.results = filmResult.films
            self.maxPageCount = filmResult.pagesCount
            self.currentPage = 2
            case .failure(let error):
            print(error)
        }
    }
    // MARK: Request more page films
//    private func requestMoreData() {
//
//        dataFetcherService.fetchBestFilms(pageNumber: String(currentPage)) { [weak self] result in
//            guard let self = self,
//                  let result = result,
//                  self.currentPage <= self.maxPageCount
//            else {return}
//
//            self.viewInput?.results += result.films
//
//            self.currentPage += 1
//        }
//    }
    }
}
extension MainPresenter: MainViewOutput {
    func viewDidRequest() {
        requestData()
    }
    func viewDidRequestMoreFilms() {
     //   requestMoreData()
    }
    func viewDidRequestMoreFilmsByCurrentKeyword() {
  //      requestMoreFilmsByCurrentKeyword()
    }
    func viewDidRequestFilmsByKeyword(keyword: String) {
        requestFilmsByKeyword(keyword: keyword)
    }
    func viewDidSelectFilm(_ film: Film) {
        openFilmDetails(with: film)
    }
}
