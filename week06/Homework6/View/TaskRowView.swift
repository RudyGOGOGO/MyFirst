//
//  TaskRow.swift
//  

import SwiftUI

struct TaskRowView: View {
  @Binding var task: Task
  /*
   adding this state to make the transition animation finish before actually changing the binding state, otherwise, the animation will not be visible
   */
  @State var isCompleted: Bool = false
  var body: some View {
    HStack {
      Text(task.title)
      Spacer()
      Image(systemName: isCompleted ? "checkmark.square" : "square")
        .foregroundColor(isCompleted ? Color.green : Color.red)
        //when the toggle happens, trigger the default transaction animation
        .onTapGesture {
          withAnimation{
            isCompleted.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
              task.isCompleted.toggle()
            }
          }
        }
    }
    .font(.title3)
    .bold()
    .padding([.top, .bottom], 15)
    .padding([.leading, .trailing], 10)
  }
}

struct TaskRow_Previews: PreviewProvider {
  static var previews: some View {
    TaskRowView(task: .constant(Task(title: "My Task", category: .noCategory, isCompleted: true)), isCompleted: true)
  }
}
