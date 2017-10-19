import XCTest
@testable import test1

class ApiClientAcceptanceTests: XCTestCase {
    
    var sut: ApiClient!
    
    override func setUp() {
        super.setUp()
        
        sut = ApiClient.shared
        sut.session = URLSession(configuration: .default)
        
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testGetSearchResults_ShouldReturn20CharactersForTermSpider() {
        let promise = expectation(description: "20 characters returned from API")
        
        XCTAssertEqual(sut.characters.count, 0, "searchReulsts (items) should be empty before the data task runs.")
        
        sut.getSearchResults(searchTerm: "Spider") { (characters, error) in
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        print(sut.characters)
        XCTAssertEqual(sut.characters.count, 20, "Count of characters should be 20")
    }
}
