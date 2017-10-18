//  MarvelAuthenticationTests.swift

import XCTest
@testable import test1

class MarvelAuthenticationTests: XCTestCase {
    
    var sut: MarverlAuthentication!
    
    override func setUp() {
        super.setUp()
        
        sut = MarverlAuthentication()
    }
    
    override func tearDown() {
        // sut = nil
        super.tearDown()
    }
    
    func testTimestamp_ShouldChangeAcrossDifferentInstance() {
        
        let ts1 = sut.timestamp
        let ts2 = MarverlAuthentication().timestamp
        
        XCTAssertNotEqual(ts1, ts2, "The timestamps do not differ")
    }
    
    func testTimestamp_ShouldNotChangeOnSameInstance() {
        let ts1 = sut.timestamp
        let ts2 = sut.timestamp
        print("\(ts1) \(ts2)")
        XCTAssertEqual(ts1, ts2, "The timestamp differ for the same instance")
    }
    
    func testPiblicKey_ShoudHave32Characters() {
        let key = sut.publicKey
        XCTAssertEqual(key.count, 32, "Public Key should have 32 characters, but in has \(key.count)")
    }
    
    func testPrivateKey_ShoudHave40Characters() {
        let key = sut.privateKey
        XCTAssertEqual(key.count, 40, "Private Key should have 40 characters, but in has \(key.count)")
    }
    
    //    func test_URLParametersShouldHaveTimeStampPublicKeyAndHash() {
    //        let sutWithFakeMD5 = TestMarvelAuthentication()
    //        sutWithFakeMD5.timestamp = "Timestamp"
    //        sutWithFakeMD5.privateKey = "Private"
    //        sutWithFakeMD5.publicKey = "Public"
    //
    //        let params = sutWithFakeMD5.urlParameters;
    //
    //        XCTAssertEqual(params, "&ts=Timestamp&apikey=Public&hash=MD5TimestampPrivatePublicMD5", "urlParameters doesn't match API requrements")
    //    }
    
    func testMD5_shoulReturnKnownResult() {
        
        let md5String = sut.MD5(string: "abc")
        XCTAssertEqual(md5String, "900150983cd24fb0d6963f7d28e17f72")
    }
    
    func testUrlParameters_ShouldHaveTimestampPublicKeyAndHash() {
        sut.timestamp = "Timestamp";
        sut.privateKey = "Private"
        sut.publicKey = "Public"
        
        // MD5("TimestampPrivatePublic") = 86588e74427d86da1d5880c33966aaef
        // check at https://www.md5hashgenerator.com/
        
        let params = sut.urlParameters
        
        let expectedResult = "&ts=Timestamp&apikey=Public&hash=86588e74427d86da1d5880c33966aaef"
        XCTAssertEqual(params, expectedResult, "urlParameters doesn't match API requrements")
    }
    
}


//class TestMarvelAuthentication: MarverlAuthentication {
//    override func MD5(string: String) -> String {
//        return "MD5\(string)MD5"
//    }
//}
