//
//  SignUpView.swift
//  ToDoFirebaseSwiftUI
//
//  Created by Preet Karia on 3/16/24.
//

import SwiftUI

struct SignUpView: View {
    @State var email = ""
    @State var password = ""
    @State var confirmPassword = ""
    @EnvironmentObject var appStateVM: AppStateViewModel
    var body: some View {
        VStack {
            
            VStack(spacing: 16) {
                
                Image("firebase-logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                    .padding(.bottom, 40)
                
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.horizontal, 16)
                    .frame(height: 50)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                
                SecureField("Password", text: $password)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.horizontal, 16)
                    .frame(height: 50)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                SecureField("Confirm Password", text: $confirmPassword)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.horizontal, 16)
                    .frame(height: 50)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            Button(action: {
                appStateVM.signUp(email: email, password: password, confirmPassword: confirmPassword)
            }) {
                Text("Sign Up")
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.vertical)
            
            if let error = appStateVM.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .padding(.top)
            }
            
            
        }
        .navigationBarTitle("Register")
        .onAppear {
            appStateVM.errorMessage = ""
        }
        
    }
}

#Preview {
    SignUpView().environmentObject(AppStateViewModel())
}
