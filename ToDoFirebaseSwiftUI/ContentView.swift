//
//  ContentView.swift
//  ToDoFirebaseSwiftUI
//
//  Created by Preet Karia on 2/18/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var appStateVM = AppStateViewModel()
    var body: some View {
        if appStateVM.isSignedIn {
            ListView().environmentObject(appStateVM)
        }
        else {
            LoginView().environmentObject(appStateVM)
        }
    }
}

#Preview {
    ContentView()
}
