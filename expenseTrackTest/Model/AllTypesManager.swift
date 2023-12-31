//
//  AllTypesManager.swift
//  expenseTrackTest
//
//  Created by Ama Ranasi on 2023-09-25.
//

import SwiftUI
import Firebase

class AllTypesManager: ObservableObject {
    @Published var allTypes : [AllTypes] = []
    
    init() {
        fetchAllTypes()
    }
    
    func fetchAllTypes() {
        allTypes.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("AllTypes")
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
             
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let id = data["id"] as? String ?? ""
                    let type = data["type"] as? String ?? ""
                    let remark = data["remark"] as? String ?? ""
                    
                    let timestamp = data["date"] as? Timestamp ?? Timestamp()
                    let date = self.dateFromTimestamp(timestamp)
                    
                    let amount = data["amount"] as? Double ?? 0.0
                    let category = data["category"] as? String ?? ""
                    
                    let allTypes = AllTypes(id: id, type: type, remark: remark, date: date, amount: amount, category: category)
                    self.allTypes.append(allTypes)
                }
            }
        }
    }
    
    func dateFromTimestamp(_ timestamp: Timestamp) -> Date {
        return timestamp.dateValue()
    }

    func addData(id: String, type: String, category: String, date: Date, remark: String, amount: Int){
        let db = Firestore.firestore()
        let ref = db.collection("AllTypes").document(id)
        ref.setData(["type": type, "id": id, "remark": remark, "date": date, "category": category, "amount": amount]){error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    
}
