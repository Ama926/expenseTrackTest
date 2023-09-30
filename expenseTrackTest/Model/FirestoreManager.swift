//
//  FirestoreManager.swift
//  expenseTrackTest
//
//  Created by Ama Ranasi on 2023-09-24.
//
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirestoreManager {
    static let shared = FirestoreManager()
    private let db = Firestore.firestore()

    func fetchMonthlyExpenses(completion: @escaping ([Expense]) -> Void) {
        let expensesCollection = db.collection("expenses")

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy 'at' HH:mm:ss 'UTC'Z"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 19800) // UTC+5:30

        let currentDate = dateFormatter.string(from: Date())

        expensesCollection
            .whereField("date", isGreaterThanOrEqualTo: "01 January 2023 at 00:00:00 UTC+5.30")
            .whereField("date", isLessThanOrEqualTo: currentDate)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error fetching documents: \(error)")
                    return
                }

                var expenses: [Expense] = []

                
                for document in querySnapshot!.documents {
                    do {
                        var data = document.data()

                        if let dateString = data["date"] as? String,
                           let date = dateFormatter.date(from: dateString) {
                            data["date"] = Timestamp(date: date)
                        }

                        if let expense = try? Firestore.Decoder().decode(Expense.self, from: data) {
                            expenses.append(expense)
                        }
                    } catch {
                        print("Error decoding expense data: \(error)")
                    }
                }
            
                print("Fetched expenses: \(expenses)")

                DispatchQueue.main.async {
                    completion(expenses)
                }
            }
    }
}

