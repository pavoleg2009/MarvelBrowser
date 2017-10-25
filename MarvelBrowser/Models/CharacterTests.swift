import XCTest
@testable import MarvelBrowser

class CharacterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitWithJson_ShouldCreateCharacterFromJson() {
        // Arrage
   
        //        let fakeJsonArrayItem: [String:Any] = [
        //            Character.ApiKeys.id : 1009157,
        //            Character.ApiKeys.name: "Spider-Girl (Anya Corazon)",
        //            Character.ApiKeys.characterDescription: "desc",
        //            Character.ApiKeys.modified: "1969-12-31T19:00:00-0500",
        //            Character.ApiKeys.thumbnail: [
        //                "path":"http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available",
        //                "extension":"jpg"
        //            ]
        //        ]
        
        let jsonString = """
        {
         "id":1009157,
         "name":"Spider-Girl (Anya Corazon)",
         "description":"desc",
         "modified":"1969-12-31T19:00:00-0500",
         "thumbnail":{
             "path":"http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available",
             "extension":"jpg"
             }
         }
        """
        let jsonData = jsonString.data(using: .utf8)
        let fakeJsonArrayItem = try! JSONSerialization.jsonObject(with: jsonData!, options: []) as! [String:Any]

        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'-'SSSS"
        df.timeZone = TimeZone(secondsFromGMT: 0)
        let dateModified = df.date(from: "1969-12-31T19:00:00-0500")
        
        // Act
        let sutCharacter = Character(json: fakeJsonArrayItem)
        // Assert
        XCTAssertNotNil(sutCharacter, "==== Character was not created from json object")
        XCTAssertEqual(sutCharacter!.id, 1009157)
        XCTAssertEqual(sutCharacter!.name, "Spider-Girl (Anya Corazon)")
        XCTAssertEqual(sutCharacter!.characterDescription, "desc")
        XCTAssertEqual(sutCharacter!.modified, dateModified)
        XCTAssertEqual(sutCharacter!.thumbnailPath, "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg")
        
    }
    
    func testInitWithIncomleteJson_ShouldReturnNil() {
        // Arrage
        let fakeJsonArrayItem: [String:Any] = [
            Character.ApiKeys.id : 1009157,
            // To fail init
            // Character.ApiKeys.name: "Spider-Girl (Anya Corazon)",
            Character.ApiKeys.characterDescription: "desc",
            Character.ApiKeys.modified: "1969-12-31T19:00:00-0500",
            Character.ApiKeys.thumbnail: [
                "path":"http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available",
                "extension":"jpg"
            ]
        ]
        // Act
        let sutCharacter = Character(json: fakeJsonArrayItem)
        // Assert
        XCTAssertNil(sutCharacter)
    }
    
    func testDescription_ShouldReturnNameAndId() {
        // Arrange
        let fakeJsonArrayItem: [String:Any] = [
            Character.ApiKeys.id : 1009157,
            Character.ApiKeys.name: "Spider-Girl (Anya Corazon)",
            Character.ApiKeys.characterDescription: "desc",
            Character.ApiKeys.modified: "1969-12-31T19:00:00-0500",
            Character.ApiKeys.thumbnail: [
                "path":"http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available",
                "extension":"jpg"
            ]
        ]
        // Act
        let sutCharacter = Character(json: fakeJsonArrayItem)
        // Assert
        XCTAssertEqual(sutCharacter?.description, "Spider-Girl (Anya Corazon) (1009157)")
    }
    
    func testDateToStringFormatter_TransformBackAndForth() {
        // Arrange
        let testString = "1969-12-31T19:00:00-0500"
        // Act
        let tempDate = Character.stringToDateFormatter.date(from: testString)
        let resultString = Character.dateToStringFormatter.string(from: tempDate!)
        // Assert
        XCTAssertEqual(resultString, "31.12.1969 19:00:00[0500]")
    }
    
    func testArray_ShouldReturnArrayOfCharactersFromResponseJsonArray() {
        // Arrange
        let jsonString = """
        [{"id":1010727,"name":"Spider-dok","description":"","modified":"1969-12-31T19:00:00-0500","thumbnail":{"path":"http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available","extension":"jpg"}},
        {"id":1009609,"name":"Spider-Girl (May Parker)","description":"May papa.","modified":"2014-03-25T13:30:33-0400","thumbnail":{"path":"http://i.annihil.us/u/prod/marvel/i/mg/1/70/4c003adccbe4f","extension":"jpg"}}]
        """
        let jsonData = jsonString.data(using: .utf8)
        let fakeJsonArray = try! JSONSerialization.jsonObject(with: jsonData!, options: []) as! [[String:Any]]
        // Act
        let characters = Character.array(jsonArray: fakeJsonArray)
        // Assert
        XCTAssertEqual(characters.count, 2)
    }
    
}
