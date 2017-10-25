//
//  UIImageView+URLTests.swift
//  MarvelBrowserTests
//
//  Created by Oleg Pavlichenkov on 25/10/2017.
//  Copyright © 2017 Oleg Pavlichenkov. All rights reserved.
//

import XCTest
@testable import MarvelBrowser

class UIImageView_URLTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPosSetImageWithNilUrl_ShouldReturnNil() {
        // Arrange
        let sutImageView = UIImageView()
        
        // Act
        let dataTask = sutImageView.pos_setImage(url: nil)
        
        // Assert
        XCTAssertNil(dataTask)
        XCTAssertNil(sutImageView.image)
    }
    

    
}
