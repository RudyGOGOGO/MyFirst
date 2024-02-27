//
//  Store.swift
//  TaskList
//
//  Created by Wei Zhang on 2/26/24.
//

import Foundation

class Store: ObservableObject, Hashable {
  static let defaultTasks = [
    Task(title: "Task 1", isCompleted: false, notes: "some notes for Task 1"),
    Task(title: "Task 2", isCompleted: false, notes: "some notes for Task 2"),
    Task(title: "Task 3", isCompleted: false, notes: "some notes for Task 3"),
    Task(title: "Task 4", isCompleted: false, notes: "some notes for Task 4"),
    Task(title: "Task 5", isCompleted: false, notes: "some notes for Task 5")
  ]
  @Published var tasks: [Task] = defaultTasks
  
  func addTask(title: String, notes: String) {
    let task = Task(title: title, isCompleted: false, notes: notes)
    tasks.append(task)
  }
  
  func updateTask(_ task: Task) {
    var idx: Int = 0
    for t in self.tasks {
      if t.id == task.id {
        break
      }
      idx += 1
    }
    self.tasks[idx] = Task(title: task.title, isCompleted: task.isCompleted, notes: task.notes)
  }
  
  static func == (lhs: Store, rhs: Store) -> Bool {
    for i in 0 ... lhs.tasks.count {
      if lhs.tasks[i].id != rhs.tasks[i].id {
        return false
      }
    }
    return true
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(self.tasks)
  }
}
