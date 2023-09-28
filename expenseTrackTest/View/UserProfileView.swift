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
    
    var body: some View {
        //if let user = $viewModel.currentUser {
            List {
                Section{
                    HStack{
                        Text("Hello")
                            .font(.title)
                            .foregroundColor(Color(.white))
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray))
                            .clipShape(Circle())
                        
                        VStack (alignment: .leading, spacing: 4){
                            Text("Ama")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top,4)
                            
                            Text("Ama")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                }
                
                Button{
                    //navigate to budget View
                    isBudgetHistoryViewPresented.toggle()
                   
                } label : {
                    Text("Add Budget")
                }
                
                .padding()
                
            
                    Button {
                        viewModel.signOut()
                    } label: {
                        HStack {
                            Image(systemName: "arrow.left.circle.fill")
                                .foregroundColor(.red)
                            Text("Sign Out")
                        }
                    }
                
                
            }
        
            .sheet(isPresented: $isBudgetHistoryViewPresented) {
                            NavigationView { // Embed BudgetHistoryView in a NavigationView
                                BudgetEntryView()
                                    .navigationBarTitle("Budget History", displayMode: .inline)
                                    .navigationBarItems(trailing: Button("Close") {
                                        isBudgetHistoryViewPresented.toggle()
                                    })
                            }
                        }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
