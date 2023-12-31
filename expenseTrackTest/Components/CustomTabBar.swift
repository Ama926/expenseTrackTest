//
//  CustomTabBar.swift
//  expenseTrackTest
//
//  Created by Ama Ranasi on 2023-09-27.
//

import SwiftUI

enum Tabs: Int {
    case home = 0
    case records = 1
    case add = 2
    case report = 3
    case profile = 4
}

struct CustomTabBar: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Binding var selectedTabs: Tabs

    var body: some View {
        HStack (spacing: 30) {
            
            Button {
                //expense
                selectedTabs = .home
            } label: {
                VStack (alignment: .center, spacing: 4) {
                    Image(systemName: "tray.and.arrow.up.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                    Text("Expense")
                        .font(Font.footnote)
                }
            }
            
            Button {
                //report
                selectedTabs = .records
            } label: {
                VStack (alignment: .center, spacing: 4) {
                    Image(systemName: "chart.bar.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                    Text("Report")
                        .font(Font.footnote)
                }
            }

            Button {
                //Add
                selectedTabs = .add
            } label: {
                VStack (alignment: .center, spacing: 4) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                    Text("Add")
                        .font(Font.footnote)
                }
            }
            
            Button {
                
                selectedTabs = .report
            } label: {
                VStack (alignment: .center, spacing: 4) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                    Text("Report")
                        .font(Font.footnote)
                }
            }

            Button {
                //profile
                selectedTabs = .profile
            } label: {
                VStack (alignment: .center, spacing: 4) {
                    Image(systemName: "chart.bar.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                    Text("Profile")
                        .font(Font.footnote)
                }
            }
        }
        .frame(height: 82)
    }
}

