//
//  ImageDownloader.swift
//  homework09
//
//  Created by Wei Zhang on 3/25/24.
//

import Foundation

class ImageSearch: ObservableObject {
  enum ImageSearchError: Error {
    case invalidResponse
  }
  private let session: URLSession
  private let sessionConfiguration: URLSessionConfiguration
  private let baseURL: URL
  private let searchEndpoint: URL
  private var apiKey: String
  private let decoder = JSONDecoder()
  
  init() {
    self.sessionConfiguration = URLSessionConfiguration.default
    self.session = URLSession(configuration: sessionConfiguration)
    self.baseURL = URL(string: "https://api.pexels.com/v1/")!
    self.searchEndpoint = URL(string: "search", relativeTo: baseURL)!
    guard let filePath = Bundle.main.path(forResource: "pexels", ofType: "plist") else {
      fatalError("Couldn't find file 'pexels.plist'.")
    }
    // 2
    let plist = NSDictionary(contentsOfFile: filePath)
    guard let value = plist?.object(forKey: "apikey") as? String else {
      fatalError("Couldn't find key 'apikey' in 'pexels.plist'.")
    }
    self.apiKey = value
  }
  
  func downloadImage(keyword: String) async throws -> [ImageModel] {
    var searchRequest = URLRequest(url: searchEndpoint)
    searchRequest.httpMethod = "GET"
    searchRequest.allHTTPHeaderFields = [
      "accept": "application/json",
      "content-type": "application/json",
      "Authorization": "\(self.apiKey)"
    ]
    let queryParams = [
      URLQueryItem(name: "query", value: keyword),
      URLQueryItem(name: "per_page", value: "10"),
    ]
    searchRequest.url?.append(queryItems: queryParams)
    let (imageRespBody, response) = try await session.data(for: searchRequest)
    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200
    else {
      throw ImageSearchError.invalidResponse
    }
    do {
      let imageResponse = try decoder.decode(ImageResponse.self, from: imageRespBody)
      return imageResponse.photos
    } catch let error {
      print(error)
    }
    return []
  }
}
