import SwiftUI

struct BigTitle: View {
  var text: String
  var body: some View {
    Text(text)
      .bold()
      .multilineTextAlignment(.center)
      .font(.largeTitle)
      .kerning(-1)//Learning Note: use the negative value to tighten space between characters
      .foregroundColor(Color("TextColor"))//Learning Note: use the TextColor Asset to dynamically adjust to different modes
  }
}

struct SliderLabel: View {
  var value: Int
  var body: some View {
    Text("\(value)")
      .font(.callout)
      .foregroundColor(Color("TextColor"))
  }
}

struct SliderTitle: View {
  var text: String
  var body: some View {
    Text(text)
      .multilineTextAlignment(.center)
      .font(.title3)
      .foregroundColor(Color("TextColor"))
  }
}

struct ButtonText: View {
  var text: String

  var body: some View {
    Text(text)
      .bold()
      .padding()
      .background(
        Color.blue
      )
      .foregroundColor(.white)
      .cornerRadius(Constants.TextValue.cornerRadius)
  }
}


#Preview {
  VStack {
    BigTitle(text: "Color Picker")
    SliderTitle(text: "Red")
    SliderLabel(value: 200)
    ButtonText(text: "Set Color")
  }
}
