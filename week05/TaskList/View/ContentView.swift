//
//  ContentView.swift
//  TaskList
//
//  Created by Wei Zhang on 2/26/24.
//

import SwiftUI

struct NewTaskButton: View {
  var body: some View {
    HStack {
      Image(systemName: "plus.circle.fill")
        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
        .padding([.leading])
        .font(.title2)
      Text("New Task")
        .font(.title3)
        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
    }
  }
}

struct ContentView: View {
  @StateObject var store: Store = Store()
  @State private var isPresented = false
  @Environment(\.dismiss) private var dismiss
  
  var body: some View {
    NavigationStack() {
      VStack(alignment: .leading) {
        Text("My Tasks")
          .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
          .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
          .padding([.leading, .top])
        ScrollView() {
          ForEach(store.tasks, id:\.id) { task in
            NavigationLink(value: task) {
              TaskRow(task: task)
                .padding([.leading, .trailing])
            }
          }
          .padding([.top])
          .navigationDestination(for: Task.self) { task in
            //Note: apply the navigationBarBackButtonHidden to the destination view
            TaskDetails(task: task, store: store).navigationBarBackButtonHidden(true)
          }
        }
        //TODO: need to figure out why it gets crashed after the second click
        NewTaskButton()
          .sheet(isPresented: $isPresented) {
            NewTask(store: store, showSheet: $isPresented, title: "", notes: "")
          }.onTapGesture {
            isPresented.toggle()
            print(isPresented)
        }
      }
    }
  }
}

#Preview {
  ContentView()
  //TODO: need to figure out why it got crashed if we set the store as @EnvironmentObject
//  ContentView().environmentObject(Store())
}
