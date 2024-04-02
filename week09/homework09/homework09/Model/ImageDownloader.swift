//
//  ImageDownload.swift
//  homework09
//
//  Created by Wei Zhang on 3/25/24.
//

import Foundation

class ImageDownloader: ObservableObject {
  enum ImageDownloader: Error {
    case invalidResponse
    case failedToDownloadImage
  }
  private let session: URLSession
  private let sessionConfiguration: URLSessionConfiguration
  private let decoder = JSONDecoder()
  
  init() {
    self.sessionConfiguration = URLSessionConfiguration.default
    self.session = URLSession(configuration: sessionConfiguration)
  }
  
  func downloadImage(at imageURL: URL) async throws -> Data {
    let (downloadURL, response) = try await session.download(from: imageURL)
    guard let httpResponse = response as? HTTPURLResponse,
      httpResponse.statusCode == 200
    else {
      throw ImageDownloader.invalidResponse
    }
    do {
      return try Data(contentsOf: downloadURL)
    } catch {
      throw ImageDownloader.failedToDownloadImage
    }
  }
}
