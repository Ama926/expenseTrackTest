//
//  AddCategories.swift
//  expenseTrackTest
//
//  Created by Ama Ranasi on 2023-09-30.
//

import SwiftUI
import Firebase

struct AddCategoryView: View {
    @State private var newCategory = ""
    @State private var categories: [String] = [] // Store existing categories
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
//            TextField("Enter a new category", text: $newCategory)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//
            TextField("Enter new category", text: $newCategory)
                .foregroundColor(.black)
                .font(.title3)
                .frame(maxWidth: .infinity, maxHeight: 30)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1)
                        .foregroundColor(.black)
                )
                .padding(.horizontal)
               
                
            Button(action: {
                saveCategory()
            }) {
                Text("Add New Category")
                    .foregroundColor(.white)
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .padding(.horizontal)
            }
            .buttonStyle(PlainButtonStyle())
            
            // List existing categories
            List(categories, id: \.self) { category in
                Text(category)
            }
            .onAppear {
                fetchCategories()
            }
        }
        .padding()
    }
    
    func saveCategory() {
        let db = Firestore.firestore()
        let categoriesRef = db.collection("categories")
        
        if !newCategory.isEmpty {
            categoriesRef.addDocument(data: ["category": newCategory]) { error in
                if let error = error {
                    print("Error adding category: \(error.localizedDescription)")
                    newCategory = ""
                } else {
                    print("Category added successfully.")
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
    
    func fetchCategories() {
        let db = Firestore.firestore()
        let categoriesRef = db.collection("categories")
        
        categoriesRef.getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching categories: \(error.localizedDescription)")
            } else {
                let categoryNames = snapshot?.documents.compactMap { $0.data()["category"] as? String } ?? []
                categories = categoryNames
            }
        }
    }
}

struct AddCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        AddCategoryView()
    }
}
