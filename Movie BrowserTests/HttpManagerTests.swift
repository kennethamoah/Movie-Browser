//
//  HttpManagerTest.swift
//  Movie BrowserTests
//
//  Created by Ken Nyame on 7/19/21.
//

import XCTest
@testable import Movie_Browser

class HttpManagerTests: XCTestCase {
    var subject: HTTPManager!

    override func setUp() {
        super.setUp()
        subject = HTTPManager.shared
    }

    func testGetRequest() throws {
        subject.get(urlString: "https://api.themoviedb.org/3/search") { result in
            switch result {
            case .success(let data):
                XCTAssertNil(data)
            case .failure(let error):
                XCTAssertNil(error)
            }
        }
        
    }
}

