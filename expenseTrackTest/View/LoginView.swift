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
    var body: some View {
        ZStack{
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack{
                HStack{
                    Text("Welcome Back")
                        .font(.largeTitle)
                        .bold()
                    
                    Spacer()
                }
                .padding()
                .padding(.top)
                
                Spacer()
                
                HStack{
                    Image(systemName: "mail")
                    TextField("Email", text: $email)
                    
                    Spacer()
                    
                    Image(systemName: "checkmark")
                        .foregroundColor(.green)
                        //.fontWeight(.bold)
                }
                .padding()
                .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 2)
                            .foregroundColor(.black)
                )
                .padding()
                
                HStack{
                    Image(systemName: "lock")
                    TextField("Password", text: $password)
                    
                    Spacer()
                    
                    Image(systemName: "checkmark")
                        .foregroundColor(.green)
                        //.fontWeight(.bold)
                }
                .padding()
                .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 2)
                            .foregroundColor(.black)
                )
                .padding()
                
                Button(action: {
                    withAnimation{
                        self.currentShowingView = "signup"
                    }
                }){
                    Text("Don't have an account?")
                        .foregroundColor(.black.opacity(0.7))
                }
                Spacer()
                Spacer()
                
                Button{
                    Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                        if let error = error {
                            print(error)
                            return
                        }
                        
                        if let authResult = authResult{
                            print(authResult.user.uid)
                            withAnimation{
                                userID = authResult.user.uid
                            }
                        }
                        
                    }
                
                } label: {
                    Text("Sign In")
                        .foregroundColor(.white)
                        .font(.title3)
                        .bold()
                    
                        .frame(maxWidth: .infinity)
                        .padding()
                    
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.black)
                        )
                        .padding(.horizontal)
                }
            }
            
            
        }
    }
}

