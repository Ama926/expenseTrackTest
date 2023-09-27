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
    @State var selectedTab: Tabs = .expense
    
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
            
//            TabView{
//
//                Home()
//                    .tabItem(){
//                        Image(systemName: "house.fill")
//                        Text("Dashboard")
//                    }
//                ReportView()
//                    .tabItem(){
//                        Image(systemName: "phone.fill")
//                        Text("Report")
//                    }
//                ListView()
//                    .tabItem(){
//                        Image(systemName: "person.2.fill")
//                        Text("Profile")
//                    }
//
//                BarChartView()
//                    .tabItem(){
//                        Image(systemName: "person.2.fill")
//                        Text("BCV")
//                    }
//            }
            
 //           TabView(selection: $)
            
            TabView(selection: $selectedTab){
                Home()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                }
                    .tag(Tabs.expense)
                
                ListView()
                    .tabItem {
                        Label("List", systemImage: "phone.fill")
                }
                    .tag(Tabs.add)
                
                ReportView()
                    .tabItem {
                        Label("Report", systemImage: "house.fill")
                }
                    .tag(Tabs.report)
                
                UserProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.2.fill")
                }
                    .tag(Tabs.profile)
            }
            
        }
        
    }
}



//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
