//
//  DataFetcherServiceTests.swift
//  MoviesMVPTests
//
//  Created by Александр Ипатов on 23.04.2021.
//

import XCTest
@testable import MoviesMVP

class DataFetcherServiceTests: XCTestCase {

    let networkDataFetcher = NetworkDataFetcher()

    func testfetchBestFilms() throws {
        let fetchEvents = expectation(description: "fetchBestFilms")
        let dataFetcherService = DataFetcherService(networkDataFetcher: networkDataFetcher)
        dataFetcherService.fetchBestFilms(pageNumber: "1") { (result) in
            if let result = result {
                XCTAssertEqual(result.films.count, 20)
                fetchEvents.fulfill()
            } else {
            XCTFail("error")
            }
        }
        waitForExpectations(timeout: 10)
    }
    func testfetchFilmById() throws {
        let fetchEvents = expectation(description: "fetchFilmById")
        let dataFetcherService = DataFetcherService(networkDataFetcher: networkDataFetcher)
        dataFetcherService.fetchFilmById(id: "762738") { (result) in
            if let result = result {
                XCTAssertEqual(result.data.countries?.count, 2)
                fetchEvents.fulfill()
            } else {
            XCTFail("error")
            }
        }
        waitForExpectations(timeout: 10)
    }
    func testsearchFilmByKeyword() throws {
        let fetchEvents = expectation(description: "searchFilmByKeyword")
        let dataFetcherService = DataFetcherService(networkDataFetcher: networkDataFetcher)
        dataFetcherService.searchFilmByKeyword(keyword: "Джон уик") { (result) in
            if let result = result {
                XCTAssertEqual(result.films.first?.filmID, 762738)
                fetchEvents.fulfill()
            } else {
            XCTFail("error")
            }
        }
        waitForExpectations(timeout: 10)
    }

}
