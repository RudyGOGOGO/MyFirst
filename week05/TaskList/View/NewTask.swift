//
//  NewTask.swift
//  TaskList
//
//  Created by Wei Zhang on 2/27/24.
//

import SwiftUI

struct NewTask: View {
  @ObservedObject var store: Store
  @Binding var showSheet: Bool
  @State var title: String
  @State var notes: String
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("TASK TITLE")) {
          SuperTextField(placeholder: Text("Title").foregroundColor(.gray), text: $title, isMultipleLine: false)
        }
        Section(header: Text("NOTES")) {
          SuperTextField(placeholder: Text("Notes").foregroundColor(.gray), text: $notes, isMultipleLine: true)
        }
      }
      .navigationBarItems(
        leading:
          Button(action: {
            showSheet.toggle()
            print("showSheet", showSheet)
            dismiss()
          }) {
            HStack {
              Text("Cancel")
            }
          },
        trailing:
          Button(action: {
            updateStore()
            dismiss()
          }) {
            HStack {
              Text("Add")
            }
          }.disabled(title == "")
      )
    }
  }
  
  func updateStore() {
    store.addTask(title: title, notes: notes)
    showSheet.toggle()
  }
}

//Support the different color for placeholder and multiple lines
struct SuperTextField: View {
  var placeholder: Text
  @Binding var text: String
  var editingChanged: (Bool)->() = { _ in }
  var commit: ()->() = { }
  var isMultipleLine: Bool
  
  var body: some View {
    ZStack(alignment: .leading) {
      if text.isEmpty { placeholder }
      if isMultipleLine {
        ZStack{
          TextEditor(text: $text)
          Text(text).opacity(0).lineLimit(10)
        }
      } else {
        TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
      }
    }
  }
  
}

#Preview {
  VStack{
    NewTask(store: Store(), showSheet: Binding(projectedValue: .constant(true)), title: "", notes: "")
  }
}
