//
//  CustomTabBar.swift
//  expenseTrackTest
//
//  Created by Ama Ranasi on 2023-09-27.
//

import SwiftUI

enum Tabs: Int {
    case expense = 0
    case report = 1
    case add = 2
    case category = 3
    case profile = 4
}

struct CustomTabBar: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Binding var selectedTabs: Tabs

    var body: some View {
        HStack (spacing: 30) {

            Button {
                //expense
                selectedTabs = .expense
            } label: {
                VStack (alignment: .center, spacing: 4) {
                    Image(systemName: "tray.and.arrow.up.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    Text("Expense")
                        .font(Font.footnote)
                }
            }
            
            Button {
                //report
                selectedTabs = .report
            } label: {
                VStack (alignment: .center, spacing: 4) {
                    Image(systemName: "chart.bar.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
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
                    Text("Add")
                        .font(Font.footnote)
                }
            }

//            Button {
//                //Category
//                selectedTabs = .category
//            } label: {
//                VStack (alignment: .center, spacing: 4) {
//                    Image(systemName: "list.clipboard.fill")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 24, height: 24)
//                    Text("Category")
//                        .font(Font.footnote)
//                }
//            }

            Button {
                //profile
                selectedTabs = .profile
            } label: {
                VStack (alignment: .center, spacing: 4) {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    Text("Profile")
                        .font(Font.footnote)
                }
            }
        }
        .frame(height: 82)
    }
}

