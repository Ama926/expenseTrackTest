//
//  ContentView.swift
//  expenseTrackTest
//
//  Created by Ama Ranasi on 2023-09-24.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @AppStorage("uid") var userID: String = ""
    
    var body: some View {
        
        if userID == "" {
            
            AuthView()
        }else {
//            Text("Logged In! \nYour User ID is: \(userID)")
//
//            Button(action: {
//                let firebaseAuth = Auth.auth()
//                do {
//                  try firebaseAuth.signOut()
//                    withAnimation{
//                        userID = ""
//                    }
//
//                } catch let signOutError as NSError {
//                  print("Error signing out: %@", signOutError)
//                }
//            }){
//                Text("Sign Out")
//            }
            //Home()
            TabView{
                Home()
                    .tabItem(){
                        Image(systemName: "house.fill")
                        Text("Dashboard")
                    }
                ReportView()
                    .tabItem(){
                        Image(systemName: "phone.fill")
                        Text("Report")
                    }
                ListView()
                    .tabItem(){
                        Image(systemName: "person.2.fill")
                        Text("Profile")
                    }
                
                BarChartView()
                    .tabItem(){
                        Image(systemName: "person.2.fill")
                        Text("BCV")
                    }
            }
        }
        
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
