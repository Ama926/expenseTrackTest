//
//  expenseTrackTestApp.swift
//  expenseTrackTest
//
//  Created by Ama Ranasi on 2023-09-24.
//

import SwiftUI
import FirebaseCore
@main
struct expenseTrackTestApp: App {
    @StateObject var contentViewModel = ContentViewModel(currentShowingView: .constant(""))
    @StateObject var allTypesManager = AllTypesManager()
    @StateObject var authView = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    } 
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(allTypesManager)
                .environmentObject(authView)
                .environmentObject(contentViewModel)
            
        }
    }
}
