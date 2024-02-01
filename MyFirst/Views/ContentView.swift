import SwiftUI

struct ContentView: View {
  @State private var shapeColor: Color = Color(red: 0.3882, green: 0.1569, blue: 0.2941)
  @State private var redSliderValue: Double = 99.0
  @State private var greenSliderValue: Double = 40.0
  @State private var blueSliderValue: Double = 75.0
  private let colorMaxConstant: Double = 255
  private let colorMinConstant: Double = 0
  
  var body: some View {
    VStack {
      Text("Color Picker")
        .font(.title)
      //TODO: how to set the relative width and height for the shape to make it automatically fill the screen when the screen gets oriented
      RoundedRectangle(cornerRadius: 0)
        .fill(shapeColor)
        .frame(width: 350, height: 300)
      
      //TODO: need to define a model to encapsulate the following components - Text title && slider && slider value
      Text("Red")
        .font(.title3)
      HStack{
        Slider(value: $redSliderValue, in:colorMinConstant ... colorMaxConstant)
        Text(colorValueAsString(colorValue: redSliderValue))
      }
      
      Text("Green")
        .font(.title3)
      HStack{
        Slider(value: $greenSliderValue, in:colorMinConstant ... colorMaxConstant)
        Text(colorValueAsString(colorValue: greenSliderValue))
      }
      
      Text("Blue")
        .font(.title3)
      HStack{
        Slider(value: $blueSliderValue, in:colorMinConstant ... colorMaxConstant)
        Text(colorValueAsString(colorValue: blueSliderValue))
      }
      
      Button("Set Color", action: changeColor)
    }
    .padding()
  }
  
  func changeColor() {
    self.shapeColor = Color(red: redSliderValue/colorMaxConstant,
                            green: greenSliderValue/colorMaxConstant,
                            blue: blueSliderValue/colorMaxConstant)
  }
  
  func colorValueAsString(colorValue: Double) -> String {
    "\(Int(colorValue.rounded()))"
  }

}

#Preview {
  Group {
    ContentView()
  }
}
