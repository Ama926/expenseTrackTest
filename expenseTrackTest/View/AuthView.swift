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
//                let firebaseAuth = Auth.auth()
//                do {
//                  try firebaseAuth.signOut()
//                    print("signout")
//
//                } catch let signOutError as NSError {
//                  print("Error signing out: %@", signOutError)
//                }
        
             
            
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
        
        

    }
}



struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}

