import SwiftUI

struct SliderView: View {
  @Binding var sliderValue: Double
  
  let sliderTitle: String
  var sliderColor: Color = .blue
  var body: some View {
    VStack{
      SliderTitle(text: sliderTitle)
      Spacer()
      HStack{
        Slider(value: $sliderValue, in:Constants.ColorValue.colorMin ... Constants.ColorValue.colorMax)
        SliderLabel(value: Int(sliderValue.rounded()))
      }
    }
    .accentColor(sliderColor)
    .padding(Constants.PaddingValue.sliderPadding)
  }
}

#Preview {
  VStack {
    SliderView(sliderValue: Binding.constant(Constants.ColorValue.colorMax), sliderTitle: "Red", sliderColor: .red)
    SliderView(sliderValue: Binding.constant(Constants.ColorValue.colorMax), sliderTitle: "Green", sliderColor: .green)
    SliderView(sliderValue: Binding.constant(Constants.ColorValue.colorMax), sliderTitle: "Blue", sliderColor: .blue)
  }
}
