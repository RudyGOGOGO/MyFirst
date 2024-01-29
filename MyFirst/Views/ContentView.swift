import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundStyle(.tint)
    }
    .padding()
  }
}

#Preview {
  Group {
    ContentView()
    ContentView().previewDevice(PreviewDevice(rawValue: "iPhone 8"))
  }
}
