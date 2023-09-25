//
//  Home.swift
//  expenseTrackTest
//
//  Created by Ama Ranasi on 2023-09-24.
//

import SwiftUI

struct Home: View {
    @AppStorage("uid") var userID: String = ""
    var body: some View {
        Text(userID)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
