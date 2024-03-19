//
//  APIDownloader.swift
//  homework08
//
//  Created by Wei Zhang on 3/18/24.
//

import Foundation
/*
 Note: The following codes are based on the reference: https://github.com/RudyGOGOGO/ios-bootcamp-data-networking-beginning/blob/versions/6.0/12-handle-errors/12-final/RazeTunes/Model/SongDownloader.swift
 */

class APIDownloader: ObservableObject {
  enum APIDownloaderError: Error {
    case documentDirectoryError
    case failedToStoreSong
    case invalidResponse
    case unexpectedError
  }
  @Published var downloadLocation: URL?
  @Published var resourceFileName: String?
  @Published var apiList: [API] = []
  private let session: URLSession
  private let sessionConfiguration: URLSessionConfiguration
  init() {
    self.sessionConfiguration = URLSessionConfiguration.default
    self.session = URLSession(configuration: sessionConfiguration)
  }
  func downloadAPIs(at url: URL) async throws {
    do {
      let (downloadURL, response) = try await session.download(from: url)
      guard let httpResponse = response as? HTTPURLResponse,
        httpResponse.statusCode == 200
      else {
        throw APIDownloaderError.invalidResponse
      }
      let fileManager = FileManager.default
      guard let documentsPath = fileManager.urls(for: .documentDirectory,in: .userDomainMask).first
      else {
        throw APIDownloaderError.documentDirectoryError
      }
      let lastPathComponent = url.lastPathComponent
      let destinationURL = documentsPath.appendingPathComponent(lastPathComponent)
      
      do {
        if fileManager.fileExists(atPath: destinationURL.path) {
          try fileManager.removeItem(at: destinationURL)
        }
        try fileManager.copyItem(at: downloadURL, to: destinationURL)
      } catch {
        throw APIDownloaderError.failedToStoreSong
      }
      await MainActor.run {
        downloadLocation = destinationURL
        resourceFileName = lastPathComponent
        apiList = loadJSONAPIList(fileName: lastPathComponent)
      }
    } catch {
      print("Unexpected error: \(error).")
      throw APIDownloaderError.unexpectedError
    }
  }
  private func loadJSONAPIList(fileName: String) -> [API] {
    let tasksJSONURL = URL(fileURLWithPath: fileName, relativeTo: FileManager.documentsDirectoryURL)
    return decodeJSONInput(tasksJSONURL: tasksJSONURL)
  }
  private func decodeJSONInput(tasksJSONURL: URL) -> [API] {
    let decoder = JSONDecoder()
    do {
      let tasksData = try Data(contentsOf: tasksJSONURL)
      let apiInput = try decoder.decode(APIInput.self, from: tasksData)
      return apiInput.entries
    } catch let error {
      print(error)
      return []
    }
  }
}
