//
//  TaskRow.swift
//  

import SwiftUI

struct TaskRowView: View {
  @Binding var task: Task
  @State var isCompleted: Bool
  var body: some View {
    HStack {
      Text(task.title)
      Spacer()
      Image(systemName: task.isCompleted ? "checkmark.square" : "square")
        .foregroundColor(task.isCompleted ? Color.green : Color.red)
        //when the toggle happens, trigger the default transaction animation
        .onTapGesture {
          /*
           An animation type with duration is included to give a known time to animation. Finally the deadline for the asyncAfter is .now() + 2 to ensure the animation gets a chance to complete for the view is redrawn. 
           */
          withAnimation(.easeInOut(duration: 2)){
            isCompleted.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
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
