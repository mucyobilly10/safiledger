//
//  LedgerViewModel.swift
//  SafiLedger
//
//  Created by billy Auca on 29/10/2026.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class LedgerViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    private let db = Firestore.firestore()

    // READ: Listen to the "transactions" collection, but ONLY for the current user
    func listen() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        db.collection("transactions")
            .whereField("ownerID", isEqualTo: uid)
            .addSnapshotListener { snapshot, error in
                guard let documents = snapshot?.documents else { return }
                self.transactions = documents.compactMap { doc in
                    try? doc.data(as: Transaction.self)
                }
            }
    }

    // WRITE: Save a new transaction to the cloud, stamped with the user's ID
    func add(_ transaction: Transaction) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        var newTxn = transaction
        newTxn.ownerID = uid // Stamp the owner
        
        do {
            try db.collection("transactions").addDocument(from: newTxn)
        } catch {
            print("Could not save: \(error)")
        }
    }
    
    // Helper to calculate running balance
    var balance: Int {
        transactions.filter { $0.status == .cleared }.reduce(0) { $0 + $1.amount }
    }
}
