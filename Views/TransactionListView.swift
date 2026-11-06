//
//  TransactionListView.swift
//  SafiLedger
//
//  Created by billy Auca on 29/10/2026.
//

import SwiftUI
import FirebaseAuth

struct TransactionListView: View {
    @StateObject private var vm = LedgerViewModel()
    @EnvironmentObject var auth: AuthViewModel

    var body: some View {
        NavigationStack {
            List(vm.transactions) { txn in
                VStack(alignment: .leading, spacing: 4) {
                    Text(txn.summary)
                        .font(.headline)
                        .foregroundColor(txn.status == .flagged ? .red : (txn.amount >= 0 ? .green : .primary))
                    Text("Day \(txn.day) at \(txn.hour):00")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("My Ledger")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Sign Out") {
                        auth.signOut()
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    Button("Add Test Transaction") {
                        let randomAmount = Int.random(in: -50000...50000)
                        let newTxn = Transaction(
                            amount: randomAmount,
                            hour: Int.random(in: 8...18),
                            day: 1,
                            kind: randomAmount > 0 ? "MoMo" : "Supplier",
                            status: .pending
                        )
                        vm.add(newTxn)
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
        .onAppear {
            vm.listen() // Start the live connection to Firestore
        }
    }
}

