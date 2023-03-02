//
//  MockMovieResponseUnitTest.swift
//  TMDBCoppelTestTests
//
//  Created by Jael  on 28/02/23.
//

import XCTest
protocol APIClient {
    func getMovies(completion: @escaping (Result<[MovieResponse], Error>) -> Void)
}
class MockAPIClient: APIClient {
    func getMovies(completion: @escaping (Result<[MovieResponse], Error>) -> Void) {
        let movie = MovieResponse(adult: false,
                                  backdroppath: "/ndlQ2Cuc3cjTL7lTynw6I4boP4S.jpg",
                                  id: 297761,
                                  genreids: [14, 28, 80],
                                  originallanguage: .en,
                                  releasedate: "2016-08-03",
                                  originaltitle: "Suicide Squad",
                                  overview: "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences.",
                                  popularity: 48.261451,
                                  posterpath: "/e1mjopzAS2KNsvpbpahQ1a6SkSn.jpg",
                                  title: "Suicide Squad",
                                  video: false,
                                  voteaverage: 5.91,
                                  votecount: 1466)
        completion(.success([movie]))
    }
}


final class MockMovieResponseUnitTest: XCTestCase {
    
    var apiClient: APIClient!
    
    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
    }
    
    func testGetMovies() {
        let expectation = XCTestExpectation(description: "Movies are fetched successfully")
        
        apiClient.getMovies { result in
            switch result {
            case .success(let movies):
                XCTAssertNotNil(movies)
                XCTAssertEqual(movies.count, 1)
                
                let movie = movies[0]
                XCTAssertEqual(movie.title, "Suicide Squad")
                XCTAssertEqual(movie.id, 297761)
                XCTAssertEqual(movie.genreids, [14, 28, 80])
                XCTAssertEqual(movie.overview, "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences.")
                
                expectation.fulfill()
                
            case .failure(let error):
                XCTFail("Error fetching movies: \(error.localizedDescription)")
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
}
