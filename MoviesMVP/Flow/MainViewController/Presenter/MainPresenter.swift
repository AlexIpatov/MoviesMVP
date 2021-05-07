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
    func showError()
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
    private var currentPage: Int = 1
    private var maxPageCount: Int = 0
    weak var viewInput: (UIViewController & MainViewInput)?

    let dataFetcherService: DataFetcherService

    init(dataFetcherService: DataFetcherService) {
        self.dataFetcherService = dataFetcherService
    }

    // MARK: - Open next vc
    private func openFilmDetails(with film: Film) {
        let detailVC = DetailBuilder.build(dataFetcherService: dataFetcherService, with: film)
        viewInput?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
// MARK: - Network requests
extension MainPresenter {
    // MARK: Request films by keyword
    private func requestFilmsByKeyword(keyword: String) {
        dataFetcherService.searchFilmByKeyword(keyword: keyword) {[weak self] result in
            guard let self = self,
                  let result = result
                  else {return}
            self.viewInput?.searchResults = result.films
            self.maxPageCount = result.pagesCount
            print(result.pagesCount)
            self.currentKeyword = result.keyword
            self.currentPage = 1
        }
    }
    private func requestMoreFilmsByCurrentKeyword() {
        dataFetcherService.searchFilmByKeyword(keyword: currentKeyword ?? "",
                                               pageNumber: String(currentPage)) { [weak self] result in
            guard let self = self,
                  let result = result,
                  self.currentPage <= self.maxPageCount
            else {return}

            self.viewInput?.searchResults += result.films

            self.currentPage += 1
        }
    }
    // MARK: Request best 250 films
    private func requestData() {
        dataFetcherService.fetchBestFilms { [weak self] result in
            guard let self = self,
                  let result = result
                  else {return}
            self.viewInput?.results = result.films
            self.maxPageCount = result.pagesCount
            self.currentPage = 1
        }
    }
    // MARK: Request more page films
    private func requestMoreData() {
        dataFetcherService.fetchBestFilms(pageNumber: String(currentPage)) { [weak self] result in
            guard let self = self,
                  let result = result,
                  self.currentPage <= self.maxPageCount
            else {return}

            self.viewInput?.results += result.films

            self.currentPage += 1
        }
    }
}

extension MainPresenter: MainViewOutput {
    func viewDidRequest() {
        requestData()
    }
    func viewDidRequestMoreFilms() {
        requestMoreData()
    }
    func viewDidRequestMoreFilmsByCurrentKeyword() {
        requestMoreFilmsByCurrentKeyword()
    }
    func viewDidRequestFilmsByKeyword(keyword: String) {
        requestFilmsByKeyword(keyword: keyword)
    }
    func viewDidSelectFilm(_ film: Film) {
        openFilmDetails(with: film)
    }
}
