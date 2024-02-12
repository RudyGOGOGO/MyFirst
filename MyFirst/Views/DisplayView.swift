import SwiftUI

struct DisplayView: View {
  @Binding var displayColor: Color
  var body: some View {
    RoundedRectangle(cornerRadius: 0)
      .fill(displayColor)
      .overlay(
        RoundedRectangle(cornerRadius: 0)
          .strokeBorder(Color("PaddingColor"), lineWidth: 10)
      )
  }
}

#Preview {
  VStack {
    DisplayView(displayColor: Binding.constant(.red))
    DisplayView(displayColor: Binding.constant(.blue))
    DisplayView(displayColor: Binding.constant(.green))
  }
}
