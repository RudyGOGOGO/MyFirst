//
//  TaskRow.swift
//  TaskList
//
//  Created by Wei Zhang on 2/26/24.
//

import SwiftUI

/*
 Create a view to support conditional modifier, reference: https://www.avanderlee.com/swiftui/conditional-view-modifier/
 Applies the given transform if the given condition evaluates to `true`.
 - Parameters:
  - condition: The condition to evaluate.
  - transform: The transform to apply to the source `View`.
 - Returns: Either the original `View` or the modified `View` if the condition is `true`.
 */
extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

struct TaskRow: View {
  let task: Task
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack() {
        Text(task.title)
          .font(.title2)
          .fontWeight(.heavy)
          .foregroundStyle(.blue)
        
        Spacer()
///approach 1: bad implementation(build the wheel) - draw a square with checkmark
//        Rectangle()
//          .strokeBorder(task.isCompleted ? .green : .red, lineWidth: 3)
//          .frame(width: 20, height: 20)
//          .padding()
//          .if(task.isCompleted) { view in
//            view.overlay(
//              Image(systemName: "checkmark")//SFSymbol checkmark
//                .scaledToFit()
//                .foregroundColor(.green)
//            )
//          }
        //approach 2: use the SFSymbol
        Image(systemName: task.isCompleted ? "checkmark.square" : "square")
          .font(Font.title3.weight(.bold))//customize the symbol weight and size
          .scaledToFit()
          .foregroundColor(task.isCompleted ? .green : .red)
        
      }
      Text(task.notes)
        .font(.caption)
        .fontWeight(.light)
        .foregroundColor(.black)
      Divider()
    }.padding(EdgeInsets(top: 0, leading: Constants.PaddingValue.horizontalPadding, bottom: 0, trailing: Constants.PaddingValue.horizontalPadding))
  }
}

#Preview {
  TaskRow(task: Task(title: "Task 1", isCompleted: true, notes: "123"))
}
