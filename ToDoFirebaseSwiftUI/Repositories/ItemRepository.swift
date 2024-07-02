//
//  ItemRepository.swift
//  ToDoFirebaseSwiftUI
//
//  Created by Preet Karia on 3/11/24.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

public class ItemRepository: ObservableObject {
    
    @Published var items = [ToDoItem]()
    
    private let db = Firestore.firestore()
    
    private var listenerRegistration: ListenerRegistration?
    
    init() {
        subscribe()
    }
    
    deinit {
        unsubscribe()
    }
    
    func subscribe() {
        if listenerRegistration == nil {
            
            guard let userId = Auth.auth().currentUser?.uid else {
                return
            }
            let query = db.collection(ToDoItem.collectionName)
            
            listenerRegistration = query
                .order(by: "dueDate")
                .whereField("userId", isEqualTo: userId)
                .addSnapshotListener { [weak self] (querySnapshot, error) in
                    guard let documents = querySnapshot?.documents else {
                        print("No documents")
                        return
                    }
                    print("Mapping \(documents.count) documents")
                    self?.items = documents.compactMap { queryDocumentSnapshot in
                        do {
                            return try queryDocumentSnapshot.data(as: ToDoItem.self)
                        }
                        catch {
                            print("Error mapping document \(queryDocumentSnapshot.documentID): \(error.localizedDescription)")
                            return nil
                        }
                    }
                }
        }
    }
    
    func unsubscribe() {
        if listenerRegistration != nil {
            listenerRegistration?.remove()
            listenerRegistration = nil
        }
    }
    
    func addItem(item: ToDoItem) {
        do {
            try db.collection(ToDoItem.collectionName).addDocument(from: item)
        }
        catch {
            print("Unable to add item to firebase: \(error.localizedDescription)")
        }
    }
    
    func updateItem(item: ToDoItem) {
        guard let documentId = item.id else {
            print("Error documentId not found to be updated")
            return
        }
        do {
            try db.collection(ToDoItem.collectionName).document(documentId).setData(from: item)
        }
        catch {
            print("Unable to update item to firebase: \(error.localizedDescription)")
        }
    }
    
    func deleteItem(item: ToDoItem) {
        guard let documentId = item.id else {
            print("Error documentId not found to be deleted")
            return
        }
        db.collection(ToDoItem.collectionName).document(documentId).delete()
    }
}
