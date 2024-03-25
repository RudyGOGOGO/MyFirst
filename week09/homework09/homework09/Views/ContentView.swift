//
//  ContentView.swift
//  homework09
//
//  Created by Wei Zhang on 3/25/24.
//

import SwiftUI

struct ContentView: View {
  @State private var searchQuery = ""
  @State private var searchResults: [String] = []
  @ObservedObject private var imageDownloader: ImageDownloader = ImageDownloader()
  
  var body: some View {
      NavigationView {
          VStack {
              SearchBar(query: $searchQuery, onSearch: searchPhotos)
            List(searchResults, id: \.self) { photo in
                  NavigationLink(destination: ImageDetails(photo: photo)) {
                      Text(photo)
                  }
              }
          }
          .navigationTitle("Image Library")
      }
  }
  
  private func searchPhotos() {
    Task{
      @MainActor in
      self.searchResults = try await imageDownloader.downloadImage(keyword: searchQuery)
    }
  }
}

#Preview {
    ContentView()
}
