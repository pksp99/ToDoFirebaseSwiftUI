//
//  ToDoItem.swift
//  ToDoFirebaseSwiftUI
//
//  Created by Preet Karia on 2/18/24.
//

import Foundation
import FirebaseFirestore

struct ToDoItem: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String = ""
    var isRemainderSet: Bool = false
    var dueDate: Date = Date()
    var isCompleted: Bool = false
    var userId: String?
}

extension ToDoItem {
    static let collectionName = "items"
}
