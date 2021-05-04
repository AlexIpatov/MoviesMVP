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

    func testfetchEvents() throws {
        let fetchEvents = expectation(description: "fetchEvents")
        let dataFetcherService = DataFetcherService(networkDataFetcher: networkDataFetcher)
        dataFetcherService.fetchBestFilms(pageNumber: "1") { (result) in
            if let result = result {
                XCTAssertEqual(result.pagesCount, 13)
                fetchEvents.fulfill()
            } else {
            XCTFail("error")
            }
        }
        waitForExpectations(timeout: 10)
    }

}
