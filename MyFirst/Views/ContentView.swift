import SwiftUI


struct ContentView: View {
  @State private var shapeColor: Color = Color(red: 1.0, green: 100.0/Constants.ColorValue.colorMax, blue: 50/Constants.ColorValue.colorMax)
  @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
  @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
  @State private var redSliderValue: Double = Constants.ColorValue.colorMax
  @State private var greenSliderValue: Double = 100.0 //default value matching the homework
  @State private var blueSliderValue: Double = 50.0 //default value matching the homework
  //TODO: need to confirm whether the following way is general enough to handle PHONE's portrait detection
  func isPortrait() -> Bool {
    return horizontalSizeClass == .compact && verticalSizeClass == .regular
  }
  
  var body: some View {
    if isPortrait() {
      VStack {
        BigTitle(text: "Color Picker")
        DisplayView(displayColor: $shapeColor).padding(Constants.PaddingValue.displayPadding)
        ColorSelectionView(redSliderValue: $redSliderValue, greenSliderValue: $greenSliderValue, blueSliderValue: $blueSliderValue, displayColor: $shapeColor)
      }
    } else {
      HStack {
        VStack{
          BigTitle(text: "Color Picker")
          DisplayView(displayColor: $shapeColor).padding(Constants.PaddingValue.displayPadding)
        }
        ColorSelectionView(redSliderValue: $redSliderValue, greenSliderValue: $greenSliderValue, blueSliderValue: $blueSliderValue, displayColor: $shapeColor)
      }
    }
  }
  
}

#Preview {
  Group {
    ContentView()
  }
}
