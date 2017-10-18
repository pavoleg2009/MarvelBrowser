//
//  ApiClientTests.swift
//  test1Tests
//
//  Created by Oleg Pavlichenkov on 17/10/2017.
//  Copyright © 2017 Oleg Pavlichenkov. All rights reserved.
//

import XCTest
@testable import test1

class ApiClientTests: XCTestCase {
    
    var sut: ApiClient!
    
    override func setUp() {
        super.setUp()
        sut = ApiClient()
        
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "seeds1000PrettyPrinted", ofType: "json")
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
        
        XCTAssertEqual(sut.items.count, 0, "searchReulsts (items) should be empty before the data task runs.")
        
        sut.getSearchResults(searchTerm: "Spider") { (_, _) in
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertEqual(sut.items.count, 1000, "Didn't parse 1000 items from fake response")
    }
    
}
