//
//  ApiClientTests.swift
//  test1Tests
//
//  Created by Oleg Pavlichenkov on 17/10/2017.
//  Copyright © 2017 Oleg Pavlichenkov. All rights reserved.
//

import XCTest
@testable import MarvelBrowser

class ApiClientTests: XCTestCase {
    
    var sut: ApiClient!
    
    override func setUp() {
        super.setUp()
        sut = ApiClient.shared
        // get data from json file
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "charactersFakeResponse", ofType: "json")
        let data = try? Data(contentsOf:URL(fileURLWithPath: path!), options: .mappedIfSafe)
        
        let searchTerm = "Spider"
        let url = URL(string: "\(Api.baseURLString)\(Api.charactersSearchPath)\(searchTerm)")
        let urlResponse = HTTPURLResponse(url: url!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let sessionMock: URLSessionMockable = URLSessionMock(data: data, response: urlResponse, error: nil)
        
        sut.session = sessionMock
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testUpdateResults_ParsesData() {
        let promise = expectation(description: "Status code = 200")
        
        XCTAssertEqual(sut.characters.count, 0, "searchReulsts (items) should be empty before the data task runs.")
        
        sut.getSearchResults(searchTerm: "Spider") { (_, _) in
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertEqual(sut.characters.count, 20, "Didn't parse 20 characters from fake response")
    }
    
}
