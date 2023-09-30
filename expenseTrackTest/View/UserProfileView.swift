//
//  UserProfileView.swift
//  expenseTrackTest
//
//  Created by Ama Ranasi on 2023-09-24.
//

import SwiftUI

struct UserProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @AppStorage("uid") var userID: String = ""
    @State private var isBudgetHistoryViewPresented = false
    @State private var isAddCategoryViewPresented = false
    
    var body: some View {
        ZStack{
            Color.black
            VStack {
                Image("Image")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .padding(.top, 12)
                
                Text("Ama Ranasinghe")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.top, 5)
                    .foregroundColor(.white)
                
                Spacer()
                        
    //                    Button(action: {
    //                        // Navigate to budget View
    //                        isBudgetHistoryViewPresented.toggle()
    //                    }) {
    //                        Text("Add Budget")
    //                            .foregroundColor(.green)
    //                            .font(.title3)
    //                            .bold()
    //                            .frame(maxWidth: .infinity)
    //                            .padding()
    //                            .overlay(
    //                                RoundedRectangle(cornerRadius: 10)
    //                                    .stroke(lineWidth: 2)
    //                                    .foregroundColor(.green)
    //                            )
    //                            .padding(.horizontal)
    //                    }
    //                    .buttonStyle(PlainButtonStyle()) // Remove the default button style

                    Button(action: {
                        // Navigate to budget View
                        isBudgetHistoryViewPresented.toggle()
                    }) {
                        HStack {
                            Image(systemName: "dollarsign.circle.fill") // Replace "dollarsign.circle.fill" with your desired system name
                                .foregroundColor(.green)
                                .font(.title3)
                            Text("Add Budget")
                                .foregroundColor(.green)
                                .font(.title3)
                                .bold()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 2)
                                .foregroundColor(.green)
                        )
                        .padding(.horizontal)
                    }
                    .buttonStyle(PlainButtonStyle()) // Remove the default button style

                    //
                    Button(action: {
                        // Navigate to budget View
                        isAddCategoryViewPresented.toggle()
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill") // Replace "dollarsign.circle.fill" with your desired system name
                                .foregroundColor(.blue)
                                .font(.title3)
                            Text("Add Categories")
                                .foregroundColor(.blue)
                                .font(.title3)
                                .bold()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 2)
                                .foregroundColor(.blue)
                        )
                        .padding(.horizontal)
                    }
                    .buttonStyle(PlainButtonStyle()) // Remove the default button style

                
                      
                
                        Spacer()
                    
                
                        Button(action: {
                            viewModel.signOut()
                        }) {
                            HStack {
                                
                                Text("Sign Out")
                                    .foregroundColor(.white)
                                    .font(.title3)
                                    .bold()
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.red)
                                    )
                                    .padding(.horizontal)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black)
                            .foregroundColor(.white)
                           // .cornerRadius(10)
                        }
                        //.buttonStyle(PlainButtonStyle()) // Remove the default button style
                //    }
              //  }
                .background(Color.white)
                Spacer()
            }
            
        }

        .sheet(isPresented: $isBudgetHistoryViewPresented) {
            NavigationView {
                BudgetEntryView()
                    .navigationBarTitle("Budget", displayMode: .inline)
                    .navigationBarItems(trailing: Button("Close") {
                        isBudgetHistoryViewPresented.toggle()
                    })
            }
        }
        
        //isSheetPresented for AddCategories
        .sheet(isPresented: $isAddCategoryViewPresented) {
            NavigationView{
                AddCategoryView()
                    .navigationBarTitle("Add New Category", displayMode: .inline)
                    .navigationBarItems(trailing: Button("Close") {
                        isAddCategoryViewPresented.toggle()
                        
                })
            }
                }
        
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
