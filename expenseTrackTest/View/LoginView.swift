//
//  LoginView.swift
//  expenseTrackTest
//
//  Created by Ama Ranasi on 2023-09-24.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @Binding var currentShowingView: String
    @AppStorage("uid") var userID: String = ""
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var showError = false
    @State private var errorMessage = ""

    func showErrorAlert(message: String) {
        errorMessage = message
        showError = true
    }

    var body: some View {
        ZStack{
            Color.black
            
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle(.linearGradient(colors: [.green, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 1000, height: 400)
                .rotationEffect(.degrees(135))
                .offset(y: -350)
            
            VStack(spacing: 20){
                Text("Welcome")
                    .foregroundColor(.white)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .offset(x: -100, y: -100)
                
                TextField("Email", text: $email)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: email.isEmpty){
                        Text("Email")
                            .foregroundColor(.white)
                            .bold()
                    }
                
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
                
                TextField("Password", text: $password)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: email.isEmpty){
                        Text("Password")
                            .foregroundColor(.white)
                            .bold()
                    }
                    
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
                
                Button {
                    // Login
                    Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                        if let error = error {
                            print(error)
                            showErrorAlert(message: error.localizedDescription)
                            return
                        }
                        
                        if let authResult = authResult {
                            print(authResult.user.uid)
                            withAnimation {
                                userID = authResult.user.uid
                            }
                        }
                    }
                } label: {
                    Text("LOGIN")
                        .bold()
                        .frame(width: 200, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.linearGradient(colors: [.blue, .green], startPoint: .top, endPoint: .bottomTrailing))
                        )
                        .foregroundColor(.white)
                }
                .padding(.top)
                .offset(y: 100)
                
                Button(action: {
                    withAnimation {
                        self.currentShowingView = "signup"
                    }
                }) {
                    Text("Don't have an account?")
                        .foregroundColor(.white.opacity(0.7))
                }
                .padding(.top)
                .offset(y: 110)
            }
            .frame(width: 350)
            
            if showError {
                // Show error alert
                Text("Error")
                    .hidden()
                    .alert(isPresented: $showError) {
                        Alert(
                            title: Text("Error"),
                            message: Text(errorMessage),
                            dismissButton: .default(Text("OK")) {
                                showError = false
                            }
                        )
                    }
            }
        }
        .ignoresSafeArea()
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
