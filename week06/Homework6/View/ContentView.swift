import SwiftUI

struct ContentView: View {
  @StateObject var taskStore = TaskStore()
  var body: some View {
    NavigationStack {
      TabView(){
        TaskListView(taskStore: taskStore, operation: Constants.Operation.showUncompleted)
          .tabItem {
            Image(systemName: "list.bullet.circle")
            Text("Tasks")
          }
        TaskListView(taskStore: taskStore, operation: Constants.Operation.showCompleted)
          .tabItem {
            Image(systemName: "checkmark.circle")
            Text("Completed")
          }
      }
      .navigationTitle("My Tasks")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          NewTaskButtonView(taskStore: taskStore)
        }
      }
      //when there is no task, display "No Task Found"
      .overlay{if taskStore.tasks.isEmpty {Text("No Task Found")}}
    }
  }
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
