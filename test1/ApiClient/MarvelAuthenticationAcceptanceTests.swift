//
//  MarvelAuthenticationAcceptanceTests.swift
//  test1AcceptanceTests
//
//  Created by Oleg Pavlichenkov on 17/10/2017.
//  Copyright © 2017 Oleg Pavlichenkov. All rights reserved.
//

import XCTest
@testable import test1

class MarvelAuthenticationAcceptanceTests: XCTestCase {
    
    var sutAuth: MarverlAuthentication!
    var sutSession: URLSession!
    
    override func setUp() {
        super.setUp()
        sutAuth = MarverlAuthentication()
        sutSession = URLSession(configuration: .default)
    }
    
    override func tearDown() {
        sutAuth = nil
        sutSession = nil
        super.tearDown()
    }
    
    func testCallAPI_ShouldReturn200Ok() {
        // arrange / given
        
        let url = URL(string: "\(Api.baseURLString)/characters?nameStartsWith=Spider\(sutAuth.urlParameters)")!
        let promise = expectation(description: "Completion handler invoked")
        
        var statusCode: Int?
        var responseError: Error?
        
        // act / when
        sutSession.dataTask(with: url) { (_, response, error) in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }.resume()
        
        // assert / then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
}
