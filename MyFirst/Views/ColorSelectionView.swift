import SwiftUI

struct ColorSelectionView: View {
  @Binding var redSliderValue: Double
  @Binding var greenSliderValue: Double
  @Binding var blueSliderValue: Double
  @Binding var displayColor: Color
  var body: some View {
    VStack{
      SliderView(sliderValue: $redSliderValue, sliderTitle: "Red", sliderColor: .red)
      SliderView(sliderValue: $greenSliderValue, sliderTitle: "Green", sliderColor: .green)
      SliderView(sliderValue: $blueSliderValue, sliderTitle: "Blue", sliderColor: .blue)
      Button{
        self.changeColor()
      } label: {
        ButtonText(text: "Set Color")
      }
      .overlay(
        RoundedRectangle(cornerRadius: 10)
          .strokeBorder(Color.white, lineWidth: 2)
      )
    }.padding(10)
  }
  func changeColor() {
    self.displayColor = Color(red: redSliderValue/Constants.ColorValue.colorMax, green: greenSliderValue/Constants.ColorValue.colorMax, blue: blueSliderValue/Constants.ColorValue.colorMax)
  }
}

#Preview {
  ColorSelectionView(redSliderValue: Binding.constant(Constants.ColorValue.colorMax), greenSliderValue: Binding.constant(Constants.ColorValue.colorMax), blueSliderValue: Binding.constant(Constants.ColorValue.colorMax), displayColor: Binding.constant(.red))
}
