//
//  TMDBEnvironmentUnitTests.swift
//  TMDBCoppelTestTests
//
//  Created by Jael  on 01/03/23.
//

import XCTest

final class TMDBEnvironmentUnitTests: XCTestCase {

   
    func testOnTVCases() {
        let environment = "https://api.themoviedb.org/3/tv"
        let page = "1"
        XCTAssertEqual(EndpointCase.onTV(environment: environment, page: page).url, "\(environment)/on_the_air?api_key=55957fcf3ba81b137f8fc01ac5a31fb5&language=en-US&page=\(page)")
    }

    func testPopularMoviesCases() {
        let environment = "https://api.themoviedb.org/3/movie"
        let page = "2"
        XCTAssertEqual(EndpointCase.popularMovies(environment: environment, page: page).url, "\(environment)/popular?api_key=55957fcf3ba81b137f8fc01ac5a31fb5&language=en-US&page=\(page)")
    }

}
