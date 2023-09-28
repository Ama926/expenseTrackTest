//
//  FirestoreService.swift
//  expenseTrackTest
//
//  Created by Ama Ranasi on 2023-09-28.
//

import FirebaseFirestore
import Combine

class FirestoreService {
    private let db = Firestore.firestore()
    
    //fnc to save budget data to fb
    func saveBudget(month: String, categories: [String: Double]){
        let budgetData: [String: Any] = [
            "month": month,
            "categories": categories
        ]
        
        db.collection("budgets").addDocument(data: budgetData)
    }
    
    //retrieve budget history
    func getBudgetHistory(completion: @escaping ([Budget]) -> Void){
        db.collection("budgets").getDocuments {snapshot, error in
            guard let documents = snapshot?.documents else {
                completion([])
                return
            }
            
            let budgets = documents.compactMap { document -> Budget? in
                let data = document.data()
                let month = data["month"] as? String ?? ""
                let categories = data["categories"] as? [String: Double] ?? [:]
                return Budget(month: month, categories: categories)
                
            }
            
            completion(budgets)
        }
    }
}
