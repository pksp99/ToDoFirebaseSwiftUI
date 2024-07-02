//
//  ListViewModel.swift
//  ToDoFirebaseSwiftUI
//
//  Created by Preet Karia on 2/21/24.
//

import Foundation
import Firebase

class ListViewModel: ObservableObject {
    @Published var toDoItems: [ToDoItem] = []
    
    private var itemRepository: ItemRepository = ItemRepository()
    
    init() {
        itemRepository
            .$items
            .assign(to: &$toDoItems)
    }
    
    func toggleCompleted(item: ToDoItem) {
        var newItem = item
        newItem.isCompleted.toggle()
        itemRepository.updateItem(item: newItem)
    }
    
    func saveItem(item: ToDoItem) {
        if let _ = toDoItems.firstIndex(where: {$0.id == item.id}) {
            itemRepository.updateItem(item: item)
        }
        else {
            var addItem = item
            addItem.userId = Auth.auth().currentUser?.uid
            itemRepository.addItem(item: addItem)
        }
    }
    
    func deleteItem(indexSet: IndexSet) {
        for index in indexSet {
            let item = toDoItems[index]
            itemRepository.deleteItem(item: item)
        }
    }
}
