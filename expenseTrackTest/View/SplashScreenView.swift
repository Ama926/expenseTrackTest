////
////  SplashScreenView.swift
////  expenseTrackTest
////
////  Created by Ama Ranasi on 2023-09-29.
////
//
//import SwiftUI
//import FirebaseAuth
//
//struct LoginView: View {
//    @Binding var currentShowingView: String
//    @AppStorage("uid") var userID: String = ""
//
//    @State private var email: String = ""
//    @State private var password: String = ""
//    var body: some View {
//        ZStack{
//            Color.white.edgesIgnoringSafeArea(.all)
//
//            VStack{
//                HStack{
//                    Text("Enter New Budget")
//                        .font(.largeTitle)
//                        .bold()
//
//                    Spacer()
//                }
//                .padding()
//                .padding(.top)
//
//                Spacer()
//
//                HStack{
//                    TextField("Email", text: $email)
//
//                    Spacer()
//
//                }
//                .padding()
//                .overlay(
//                        RoundedRectangle(cornerRadius: 10)
//                            .stroke(lineWidth: 2)
//                            .foregroundColor(.black)
//                )
//                .padding()
//
//                HStack{
//
//                    TextField("Password", text: $password)
//
//                    Spacer()
//
//                }
//                .padding()
//                .overlay(
//                        RoundedRectangle(cornerRadius: 10)
//                            .stroke(lineWidth: 2)
//                            .foregroundColor(.black)
//                )
//                .padding()
//
//
//                Button{
//                    //
//
//                } label: {
//                    Text("Save")
//                        .foregroundColor(.white)
//                        .font(.title3)
//                        .bold()
//
//                        .frame(maxWidth: .infinity)
//                        .padding()
//
//                        .background(
//                            RoundedRectangle(cornerRadius: 10)
//                                .fill(Color.black)
//                        )
//                        .padding(.horizontal)
//                }
//            }
//
//
//        }
//    }
//}
