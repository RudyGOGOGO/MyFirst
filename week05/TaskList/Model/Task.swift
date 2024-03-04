//
//  Task.swift
//  TaskList
//
//  Created by Wei Zhang on 2/26/24.
//

import Foundation

class Task: Identifiable, ObservableObject, Hashable {
  let id = UUID()
  @Published var title: String
  @Published var isCompleted: Bool
  @Published var notes: String
  init(title: String, isCompleted: Bool, notes: String) {
    self.title = title
    self.isCompleted = isCompleted
    self.notes = notes
  }
  func hash(into hasher: inout Hasher) {
          hasher.combine(id)
  }
  static func == (lhs: Task, rhs: Task) -> Bool {
    return lhs.id == rhs.id
  }
}
