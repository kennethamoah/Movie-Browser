//
//  MoviesServiceTests.swift
//  Movie BrowserTests
//
//  Created by Ken Nyame on 7/19/21.
//

import XCTest
@testable import Movie_Browser

class MovieServiceTests: XCTestCase {

    var subject: MovieService!
    var testQuery = "Star wars"

    override func setUp() {
        super.setUp()
        subject = MovieService(httpManager: HTTPManager.shared)
    }
    
    func testSearchMoviesResponse() throws {
        subject.searchMovie(query: testQuery) { result in
            switch result {
            
            case .success(let movies):
                XCTAssertTrue(movies.count > 0, "Expected movies count is not correct")
            case .failure(let error):
                XCTAssertNil(error)
            }
        }
    }


}
