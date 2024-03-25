//
//  SearchBar.swift
//  homework09
//
//  Created by Wei Zhang on 3/25/24.
//

import SwiftUI

struct SearchBar: View {
    @Binding var query: String
    var onSearch: () -> Void
    var body: some View {
        HStack {
            TextField("Search", text: $query, onCommit: onSearch)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Search") {
                onSearch()
            }
        }
        .padding()
    }
}

//#Preview {
//  SearchBar(query: .constant("123"), onSearch: print)
//}
