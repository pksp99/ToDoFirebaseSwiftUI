//
//  DetailView.swift
//  ToDoFirebaseSwiftUI
//
//  Created by Preet Karia on 3/10/24.
//

import SwiftUI


struct DetailView: View {
    @State var toDoItem: ToDoItem
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var listVM: ListViewModel
    
    var body: some View {
        Form {
            Section(header: Text("Task Details")) {
                
                VStack(alignment: .leading) {
                    
                    TextField("Title", text: $toDoItem.title)
                        .fontWeight(.light)
                        .font(.largeTitle)
                        .foregroundColor(.primary)
                }
                Toggle("Set Reminder", isOn: $toDoItem.isRemainderSet)
                
                if toDoItem.isRemainderSet {
                    DatePicker("Due Date", selection: $toDoItem.dueDate, displayedComponents: [.date, .hourAndMinute])
                }
            }
            
            Section(header: Text("Task Status")) {
                Toggle("Completed", isOn: $toDoItem.isCompleted)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    listVM.saveItem(item: toDoItem)
                    dismiss()
                }
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        
    }
}


#Preview {
    NavigationStack {
        DetailView(toDoItem: ToDoItem()).environmentObject(ListViewModel())
    }
}
