//
//  TaskDetails.swift
//  TaskList
//
//  Created by Wei Zhang on 2/26/24.
//

import SwiftUI

///Approach 1: Bad Implementation to build the wheel by myself
//let V_PADDING = CGFloat(15)
//let H_FRAME = CGFloat(40)
//let CORNER_RADIUS = CGFloat(10)
//let BACKGROUND_COLOR = Color.init(red: 241.0/255.0, green: 241.0/255.0, blue: 245.0/255.0)
//struct TaskDetails: View {
//  @ObservedObject var task: Task
//  @Environment(\.dismiss) private var dismiss
//  var body: some View {
//    ZStack{
//      BACKGROUND_COLOR.ignoresSafeArea()
//      VStack(alignment: .leading){
//        inputField(bigTitle:"TASK TITLE", inputTitle: task.title, inputText: $task.title)
//        inputField(bigTitle:"NOTES", inputTitle: task.notes, inputText: $task.notes)
//        switchChoice(label: "Completed:", isOn: $task.isCompleted)
//      }
//    }
//    .navigationBarBackButtonHidden(false)
//    .navigationBarItems(
//      leading:
//        Button {
//          dismiss()
//        } label: {
//          HStack {
//            Image(systemName: "chevron.backward")
//            Text("Custom Back")
//          }
//        }
//    )
//  }
//}
//
//struct inputField: View {
//  let bigTitle: String
//  let inputTitle: String
//  @Binding var inputText: String
//  var body: some View {
//    VStack(alignment: .leading){
//      Text(bigTitle)
//        .foregroundColor(.gray)
//        .padding([.leading])
//      TextField(inputTitle, text: $inputText)
//        .padding(EdgeInsets(top: 0, leading: V_PADDING, bottom: 0, trailing: V_PADDING))//set the padding inside a TextField
//        .frame(height: H_FRAME)
//        .background(.white)
//        .cornerRadius(CORNER_RADIUS)
//    }.padding()
//  }
//}
//
//struct switchChoice: View {
//  let label: String
//  @Binding var isOn: Bool
//  var body: some View {
//    VStack {
//      RoundedRectangle(cornerRadius: CORNER_RADIUS)
//        .fill(.white)
//        .frame(height: H_FRAME)
//        .padding()
//        .overlay(alignment: .leading) {
//          /*
//           TODO: the magic number 13 is bad, we need to find a way to set the Toggle leading starting point as the anchored RoundedRectangle leading position
//           */
//          Toggle(label, isOn: $isOn).padding(EdgeInsets(top: 0, leading: V_PADDING + 13, bottom: 0, trailing: V_PADDING + 13))
//        }
//    }
//  }
//}

///Approach 2: Use Form and Section
struct TaskDetails: View {
  @ObservedObject var task: Task
  @ObservedObject var store: Store
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    Form {
      Section(header: Text("TASK TITLE")) {
        TextField(task.title, text: $task.title)
      }
      Section(header: Text("NOTES")) {
        TextField(task.notes, text: $task.notes)
      }
      Section() {
        Toggle("Completed:", isOn: $task.isCompleted)
      }
    }
    .navigationBarItems(
      leading:
        Button(action: {
          updateStore()
          dismiss()
        }) {
                HStack {
                  Image(systemName: "chevron.left")
                  Text("My Tasks")
                }
              }
    )
  }
  
  func updateStore() {
    store.updateTask(task)
  }
}


#Preview {
  VStack{
    TaskDetails(task: Task(title: "Task 1", isCompleted: false, notes: "notes 123"), store: Store())
  }
}

