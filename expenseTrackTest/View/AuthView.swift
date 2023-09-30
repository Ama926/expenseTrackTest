//
//  AuthView.swift
//  expenseTrackTest
//
//  Created by Ama Ranasi on 2023-09-24.
//

import SwiftUI
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @AppStorage("uid") var userID: String = ""
    @Published var currentViewShowing: String = "login"
    
    func signOut() {
//                currentViewShowing = "login"
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            withAnimation{
                userID = ""
            }
            
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
        }
}

struct AuthView: View {
    @StateObject private var viewModel = AuthViewModel() 
    
    var body: some View {
        if viewModel.currentViewShowing == "login" {
            LoginView(currentShowingView: $viewModel.currentViewShowing)
                .preferredColorScheme(.light)
        } else {
            SignUpView(currentShowingView: $viewModel.currentViewShowing)
                .preferredColorScheme(.dark)
                .transition(.move(edge: .bottom))
        }
        
        

    }
}



struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}

