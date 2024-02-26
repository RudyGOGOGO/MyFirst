import XCTest
import SwiftUI
@testable import MyFirst

final class MyFirstTests: XCTestCase {
  var colorSelectionView: ColorSelectionView!
  
  override func setUpWithError() throws {
    colorSelectionView = ColorSelectionView(redSliderValue: Binding.constant(255.0), greenSliderValue: Binding.constant(255.0), blueSliderValue: Binding.constant(255.0), displayColor: Binding.constant(Color.blue))
  }
  
  override func tearDownWithError() throws {
    colorSelectionView = nil
  }

  func testGetColorInInt() {
    /*
     TODO: Need to figure out why the following method cannot change the self.displayColor
     After reassigning a new value to the binding property displayColor, self.displayColor does not get changed
     if we directly call the following method, however, when the app runs, the binding property displayColor indeed gets updated
     when the method changeColor gets called since the State property in the ContentView gets updated so that the APP works as expected
     */
    colorSelectionView.changeColor()
    XCTAssertEqual(colorSelectionView.displayColor, Color.blue)
  }
  
}

