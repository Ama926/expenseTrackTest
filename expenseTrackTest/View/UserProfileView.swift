//
//  UserProfileView.swift
//  expenseTrackTest
//
//  Created by Ama Ranasi on 2023-09-24.
//

import SwiftUI

struct UserProfileView: View {
    var body: some View {
        ZStack {
            Color.blue
            Image(systemName: "person.fill")
                .foregroundColor(.white)
                .font(.system(size: 100.0))
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
