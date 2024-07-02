//
//  ListView.swift
//  ToDoFirebaseSwiftUI
//
//  Created by Preet Karia on 3/9/24.
//

import SwiftUI

struct ListView: View {
    @ObservedObject var listVM = ListViewModel()
    @EnvironmentObject var appStateVM: AppStateViewModel
    @State var isSheetPresented = false
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                List {
                    ForEach(listVM.toDoItems) {item in
                        HStack {
                            Image(systemName: item.isCompleted ? "checkmark.square.fill" : "square")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .onTapGesture {
                                    listVM.toggleCompleted(item: item)
                                }
                            NavigationLink {
                                DetailView(toDoItem: item).environmentObject(listVM)
                            } label: {
                                Text(item.title)
                            }
                        }
                        
                    }
                    .onDelete(perform: listVM.deleteItem)
                }
                .listStyle(.plain)
                Spacer()
                Button {
                    isSheetPresented = true
                } label: {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                        Text("Add New Task")
                    }
                    .padding()
                }
            }
            .navigationTitle("Task Tracker")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Text(appStateVM.currentUserEmail)
                        Button{
                            appStateVM.signOut()
                        } label: {
                            Text("Sign Out")
                        }
                    } label: {
                        Image(systemName: "person.fill")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading){
                    EditButton()
                }
            }
            .sheet(isPresented: $isSheetPresented) {
                NavigationStack {
                    DetailView(toDoItem: ToDoItem()).environmentObject(listVM)
                }
            }
            
        }
    }
}

#Preview {
    ListView().environmentObject(AppStateViewModel())
}
