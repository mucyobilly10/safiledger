//
//  Transaction.swift
//  SafiLedger
//
//  Created by billy Auca on 29/10/2026.
//

import Foundation
import FirebaseFirestore

// The fixed stages for a transaction
enum TxStatus: String, Codable {
    case pending, cleared, flagged, reversed
}

struct Transaction: Identifiable, Codable {
    @DocumentID var id: String?          // Firestore fills this in automatically
    var ownerID: String?                 // The UID of the user who created this
    let amount: Int
    let hour: Int
    let day: Int
    var kind: String
    var status: TxStatus
    
    // A helper to display the transaction nicely
    var summary: String {
        let sign = amount >= 0 ? "+" : ""
        let statusText = status == .flagged ? "⚠️ flagged" : "✅ cleared"
        return "\(sign)\(amount) RWF · \(kind) · \(statusText)"
    }
}
