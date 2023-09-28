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
    var body: some View {
        //if let user = $viewModel.currentUser {
            List {
                Section{
                    HStack{
                        Text(userID)
                            .font(.title)
                            .foregroundColor(Color(.white))
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray))
                            .clipShape(Circle())
                        
                        VStack (alignment: .leading, spacing: 4){
                            Text(userID)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top,4)
                            
                            Text(userID)
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                }
            
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
 //
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
