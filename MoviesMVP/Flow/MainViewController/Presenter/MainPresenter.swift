//
//  MainPresenter.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 04.05.2021.
//

import UIKit

protocol MainViewInput: AnyObject {
    var results: [Film] {get set}
    func showError()
}
protocol MainViewOutput: AnyObject {
    func viewDidRequest()
    func viewDidRequestMoreFilms()
    func viewDidSelectFilm(_ film: Film)
}
class MainPresenter {
    private var currentPage: Int = 1
    private var maxPageCount: Int = 0
    weak var viewInput: (UIViewController & MainViewInput)?

    let dataFetcherService: DataFetcherService

    init(dataFetcherService: DataFetcherService) {
        self.dataFetcherService = dataFetcherService
    }

    private func requestData() {
        dataFetcherService.fetchBestFilms { [weak self] result in
            guard let self = self else {return}
            guard let result = result else { return }
            self.viewInput?.results = result.films
            self.maxPageCount = result.pagesCount
            self.currentPage = 1
        }
    }
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
    private func openFilmDetails(with film: Film) {
        let detailVC = DetailBuilder.build(dataFetcherService: dataFetcherService, with: film)
        viewInput?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
extension MainPresenter: MainViewOutput {
    func viewDidRequest() {
        requestData()
    }
    func viewDidRequestMoreFilms() {
        requestMoreData()
    }
    func viewDidSelectFilm(_ film: Film) {
        openFilmDetails(with: film)
    }
}
