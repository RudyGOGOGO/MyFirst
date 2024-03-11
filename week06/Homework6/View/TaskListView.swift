//
//  TaskListView.swift
//

import SwiftUI

struct TaskListView: View {
  @ObservedObject var taskStore: TaskStore
  @State private var titleKeyWord: String = ""
  var operation: String = Constants.Operation.showBoth
  private var filteredTasks: [Task] {//computed property
    return taskStore.getQualifiedTaskList(operation: operation, titleKeyword: titleKeyWord)
  }
  var body: some View {
    NavigationStack{
      List(filteredTasks) { task in
        TaskItemView(task: $taskStore.tasks.first(where: { $0.id == task.id })!)
      }
      /*
       Learning Note:
       //.searchable(text: $titleKeyWord, placement: .navigationBarDrawer(displayMode: .always))
       placement: .navigationBarDrawer(displayMode: .always) makes the search bar show up when the app starts, however, it makes the title center and small
       */
      .searchable(text: $titleKeyWord)
      .navigationDestination(
        for: Task.self,
        destination: { task in
          /*
           $taskStore.tasks.first(where: { $0.id == task.id })!
           The purpose of this code is to create a navigation link that, when activated, presents the TaskDetailView for a specific task.
           By using the binding to taskStore.tasks, the view will automatically update if the underlying data changes (e.g., if a task is added, removed, or modified).
           */
          TaskDetailView(task: $taskStore.tasks.first(where: { $0.id == task.id })!)
        }
      )
      .scrollContentBackground(.hidden)//make the background invisible to match the original layout
    }
  }
}

struct TaskItemView: View {
  @Binding var task: Task
  var body: some View {
    /*
     according to the HW requirement, the original ForEach layout needs to be kept
     so, using the following ZStack as well as opacity(0.0) on NavigationLink can hide the arrow while keeping the navigation feature
     */
    ZStack{
      NavigationLink(value: task) {
        VStack {
          TaskRowView(task: $task, isCompleted: task.isCompleted)
        }
        .padding([.leading, .trailing], 10)
      }.opacity(0.0)
      TaskRowView(task: $task, isCompleted: task.isCompleted)
    }
  }
}

struct TaskListView_Previews: PreviewProvider {
  static var previews: some View {
    TaskListView(taskStore: TaskStore(), operation: Constants.Operation.showUncompleted)
  }
}
