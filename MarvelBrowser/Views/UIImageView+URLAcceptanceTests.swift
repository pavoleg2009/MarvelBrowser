
import XCTest

class UIImageView_URLAcceptanceTests: XCTestCase {
    
    func testPOS_DownloadImageFromValidURL_ShouldSetImage() {
        // Arrange
        let testURL = URL(string: "https://homepages.cae.wisc.edu/~ece533/images/airplane.png")!
        let imageView = UIImageView()
        let promise = expectation(description: "Should call after image downloaded")
        var downloadedImage: UIImage? = nil
        // Act
        imageView.pos_setImage(url: testURL) {
            downloadedImage = imageView.image
            promise.fulfill()
        }
        // Assert
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(downloadedImage)
        XCTAssertEqual(downloadedImage!.size.height, 512)
        XCTAssertEqual(downloadedImage!.size.width, 512)
    }
    
    func testPOS_DownloadImageFromWrongURL_ShouldSetImageToNil() {
        // Arrange
        let wrongURL = URL(string: "https://homepages.cae.wisc.edu/~ece533/images/airplane!.png")!
        let imageView = UIImageView()
        let promise = expectation(description: "Should call after image downloaded")
        var downloadedImage: UIImage? = nil
        // Act
        imageView.pos_setImage(url: wrongURL) {
            downloadedImage = imageView.image
            promise.fulfill()
        }
        // Assert
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(downloadedImage)
    }

    
}
