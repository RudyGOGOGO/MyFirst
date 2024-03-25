//
//  ContentView.swift
//  homework09
//
//  Created by Wei Zhang on 3/25/24.
//

import SwiftUI

struct ContentView: View {
  @MainActor @State private var searchQuery = ""
  @MainActor @State private var searchResults: [ImageModel] = []
  @ObservedObject private var imageDownloader: ImageSearch = ImageSearch()
  
  var body: some View {
    NavigationView {
      VStack {
        SearchBar(query: $searchQuery, onSearch: searchImages)
        List(searchResults, id: \.id) { image in
          VStack{
            NavigationLink(destination: ImageDetails(imageModel: image)) {
              VStack(alignment:.leading){
                Text("Photographer:" + image.photographer)
                Spacer()
                Text("Intro: " + image.alt)
              }
            }
          }
        }
      }
      .navigationTitle("Image Library")
    }
  }
  
  private func searchImages() {
    Task{
      @MainActor in
      self.searchResults = try await imageDownloader.downloadImage(keyword: searchQuery)
    }
  }
}

#Preview {
  ContentView()
}
