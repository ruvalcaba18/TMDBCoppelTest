//
//  TMDBInteractorTests.swift
//  TMDBCoppelTestTests
//
//  Created by Jael  on 28/02/23.
//

import XCTest

class MockMovieInteractorToPresenter: MovieInteractorToPresenter {
   
   
    var setOnTvCompletionHandler: (([TVShow]) -> Void)?
    var setAiringTodayCompletionHandler: (([TVShow]) -> Void)?
    var setPopularMoviesCompletionHandler: (([MovieResponse]) -> Void)?
    var setTopRatedCompletionHandler: (([MovieResponse]) -> Void)?
    
    func setPopularMovies(movies: [MovieResponse]) {
        
    }
    
    func setTopRated(movies: [MovieResponse]) {
    
    }
    
    func setOnTv(tvShows: [TVShow]) {
        
    }
    
    func setAiringToday(tvShows: [TVShow]) {
        
    }
    
    func setInternetError(error: String) {
    }
}

final class TMDBInteractorTests: XCTestCase {

       var interactor: TMDBInteractor!
       var mockPresenter: MockMovieInteractorToPresenter!
       
       override func setUp() {
           super.setUp()
           interactor = TMDBInteractor()
           mockPresenter = MockMovieInteractorToPresenter()
           interactor.presenter = mockPresenter
       }
       
       override func tearDown() {
           super.tearDown()
           interactor = nil
           mockPresenter = nil
       }
       
       func testFetchPopularMovieList() {
         let expectation = XCTestExpectation(description: "Fetch popular movie list")
           mockPresenter.setPopularMoviesCompletionHandler = { movies in
               XCTAssertEqual(movies.count, 20)
               expectation.fulfill()
           }
           interactor.fetchPopularMovieList(page: "1")
           wait(for: [expectation], timeout: 5.0)
       }
       
       func testFetchOnTV() {
           let expectation = XCTestExpectation(description: "Fetch on TV")
           interactor.fetchOnTV(page: "1")
           wait(for: [expectation], timeout: 5.0)
       }
       
       func testFetchAiringToday() {
           let expectation = XCTestExpectation(description: "Fetch airing today")
           interactor.fetchAiringToday(page: "1")
           wait(for: [expectation], timeout: 5.0)
       }
       
       func testFetchTopRated() {
           let expectation = XCTestExpectation(description: "Fetch top rated")
           interactor.fetchTopRated(page: "1")
           wait(for: [expectation], timeout: 5.0)
       }
   

}
