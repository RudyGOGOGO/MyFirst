//
//  ImageDetails.swift
//  homework09
//
//  Created by Wei Zhang on 3/25/24.
//

import SwiftUI

struct ImageDetails: View {
  var imageModel: ImageModel
  @ObservedObject private var imageDownloader = ImageDownloader()
  @MainActor @State private var image: UIImage?
  var body: some View {
    VStack {
      if image != nil {
        VStack {
          Text(String(imageModel.alt)).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
          Image(uiImage: image!)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .shadow(radius: 10)
        }
      } else {
        ProgressView()
      }
    }
    .padding()
    .onAppear(perform: {
      Task {
        await downloadImage()
      }
    })
  }
  // MARK: Functions
  private func downloadImage() async {
    guard let imageURL = URL(string: imageModel.src.large2x) else {
      return
    }
    do {
      let data = try await imageDownloader.downloadImage(at: imageURL)
      guard let img = UIImage(data: data) else {
        return
      }
      image = img
    } catch {
      print(error)
    }
  }
  
}

#Preview {
  ImageDetails(imageModel: ImageModel(id: 1, width: 100, height: 100, url: "https://www.pexels.com/photo/trees-during-day-3573351/", src: Source(original: "https://images.pexels.com/photos/3573351/pexels-photo-3573351.png", large2x: "https://images.pexels.com/photos/3573351/pexels-photo-3573351.png?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940", large: "https://images.pexels.com/photos/3573351/pexels-photo-3573351.png?auto=compress&cs=tinysrgb&h=650&w=940", medium: "https://images.pexels.com/photos/3573351/pexels-photo-3573351.png?auto=compress&cs=tinysrgb&h=350", small: "https://images.pexels.com/photos/3573351/pexels-photo-3573351.png?auto=compress&cs=tinysrgb&h=130", portrait: "https://images.pexels.com/photos/3573351/pexels-photo-3573351.png?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800", landscape: "https://images.pexels.com/photos/3573351/pexels-photo-3573351.png?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200", tiny: "https://images.pexels.com/photos/3573351/pexels-photo-3573351.png?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"),
      alt: "Brown Rocks During Golden Hour", photographer: "Lukas Rodriguez"))
}
