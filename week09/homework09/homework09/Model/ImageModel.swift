//
//  PexelsModel.swift
//  homework09
//
//  Created by Wei Zhang on 3/25/24.
//

import Foundation

struct ImageResponse: Codable {
  var totalResults: Int
  var page: Int
  var perPage: Int
  var photos: [ImageModel]
  enum CodingKeys: String, CodingKey {
      case totalResults="total_results",
           page,
           perPage="per_page",
           photos
    }
}

struct ImageModel: Codable {
  var id: Int
  var width: Int
  var height: Int
  var url: String
  var src: Source
  var alt: String
  var photographer: String
}

struct Source: Codable {
  var original: String
  var large2x: String
  var large: String
  var medium: String
  var small: String
  var portrait: String
  var landscape: String
  var tiny: String
}

