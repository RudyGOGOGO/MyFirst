//
//  homework08App.swift
//  homework08
//
//  Created by Wei Zhang on 3/18/24.
//

import SwiftUI

@main
struct homework08App: App {
    var body: some Scene {
        WindowGroup {
          ContentView(apiDownloader: APIDownloader())
        }
    }
}
