//
//  AuthView.swift
//  expenseTrackTest
//
//  Created by Ama Ranasi on 2023-09-24.
//

//import SwiftUI
//
//struct AuthView: View {
//    @State private var currentViewShowing: String = "login"
//    var body: some View {
//        if(currentViewShowing == "login"){
//            LoginView(currentShowingView: $currentViewShowing)
//                .preferredColorScheme(.light)
//
//        }else {
//            SignUpView(currentShowingView: $currentViewShowing)
//                .preferredColorScheme(.dark)
//                .transition(.move(edge: .bottom))
//        }
//    }
//}
//
//struct AuthView_Previews: PreviewProvider {
//    static var previews: some View {
//        AuthView()
//    }
//}

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
    @Published var currentViewShowing: String = "login"
    
    func signOut() {
            do {
                try Auth.auth().signOut()
                // Sign-out successful
                print("signout")
                currentViewShowing = "login"
            } catch {
                // An error occurred during sign-out
                print("Error during sign-out: \(error.localizedDescription)")
            }
        }
}

struct AuthView: View {
    @StateObject private var viewModel = AuthViewModel() // Create an instance of the AuthViewModel
    
    var body: some View {
        if viewModel.currentViewShowing == "login" {
            LoginView(currentShowingView: $viewModel.currentViewShowing)
                .preferredColorScheme(.light)
        } else {
            SignUpView(currentShowingView: $viewModel.currentViewShowing)
                .preferredColorScheme(.dark)
                .transition(.move(edge: .bottom))
        }
        
        Button(action: {
                        viewModel.signOut() // Call the signOut function from the view model
                    }) {
                        Text("Sign Out")
                            .foregroundColor(.red)
                    }
                    .padding()
    }
}



struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}

