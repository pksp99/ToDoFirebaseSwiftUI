//
//  AppStateViewModel.swift
//  ToDoFirebaseSwiftUI
//
//  Created by Preet Karia on 3/16/24.
//

import Foundation
import Firebase

class AppStateViewModel: ObservableObject {
    @Published var isSignedIn: Bool = false
    @Published var errorMessage: String? = nil
    
    let auth = Auth.auth()
    
    var currentUserEmail: String {
        if let user = auth.currentUser {
            user.email ?? "No email found"
        } else {
            "No user logged in"
        }
    }
    
    func login(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else{
                self.errorMessage = error?.localizedDescription
                return
            }
            // success
            print("Successfully Logged In")
            self.isSignedIn = true
        }
    }
    
    func signUp(email: String, password: String, confirmPassword: String) {
        if password != confirmPassword {
            self.errorMessage = "Both password should match"
            return
        }
        
        auth.createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else{
                self.errorMessage = error?.localizedDescription
                return
            }
            // success
            print("Successfully Signed Up")
            self.isSignedIn = true
        }
    }
    
    func signOut() {
        do {
            try auth.signOut()
            print("Successfully Signed Out")
            self.isSignedIn = false
        }
        catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    
}
