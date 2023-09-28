//
//  ContentView.swift
//  expenseTrackTest
//
//  Created by Ama Ranasi on 2023-09-24.
//

import SwiftUI
import Firebase

class ContentViewModel: ObservableObject {
    @EnvironmentObject var contentViewModel: ContentViewModel
   // @Published var contentViewModel : ContentViewModel
    @Binding var currentShowingView: String
    
    // Add an initializer
        init(currentShowingView: Binding<String>) {
            _currentShowingView = currentShowingView
        }
    
    func signOut() {
            
        self.currentShowingView = "login"
//                let firebaseAuth = Auth.auth()
//                do {
//                  try firebaseAuth.signOut()
//                    print("signout")
//                    self.currentShowingView = "login"
//
//                } catch let signOutError as NSError {
//                  print("Error signing out: %@", signOutError)
//                }
             
            
        }
}

struct ContentView: View {
    @AppStorage("uid") var userID: String = ""
    @State var selectedTab: Tabs = .home
    //ContentViewModel(currentShowingView: $currentShowingView)
    
    var body: some View {
        
        if userID == "" {
            AuthView()
        }else {
            TabView(selection: $selectedTab){
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                }
                    .tag(Tabs.home)
                
                ListView()
                    .tabItem {
                        Label("List", systemImage: "phone.fill")
                }
                    .tag(Tabs.add)
                
                ExpensePieChartView()
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
