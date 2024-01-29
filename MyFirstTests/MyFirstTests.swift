import XCTest
@testable import MyFirst

final class MyFirstTests: XCTestCase {
  var contentView: ContentView!
  
  override func setUpWithError() throws {
    contentView = ContentView()
  }
  
  override func tearDownWithError() throws {
    contentView = nil
  }
  
  func testGetColorInInt() {
    XCTAssertEqual(contentView.getColorInInt(colorInDouble: 20.5), 21)
    XCTAssertEqual(contentView.getColorInInt(colorInDouble: 20.5111), 21)
    XCTAssertEqual(contentView.getColorInInt(colorInDouble: 20.4), 20)
    XCTAssertEqual(contentView.getColorInInt(colorInDouble: 20.39999), 20)
  }
  
}

