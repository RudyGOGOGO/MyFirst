//
//  ImageDetails.swift
//  homework09
//
//  Created by Wei Zhang on 3/25/24.
//

import SwiftUI

struct ImageDetails: View {
  let photo: String
  var body: some View {
    VStack {
      Text(photo)
      // Display the image (you can use an AsyncImage to download it)
    }
  }
}

#Preview {
  ImageDetails(photo: "https://www.pexels.com/photo/close-up-shot-of-cypress-leaves-5546102/")
}
