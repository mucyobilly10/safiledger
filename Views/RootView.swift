//
//  RootView.swift
//  SafiLedger
//
//  Created by billy Auca on 29/10/2026.
//

import SwiftUI

struct RootView: View {
    @StateObject private var auth = AuthViewModel()

    var body: some View {
        if auth.user != nil {
            TransactionListView()
                .environmentObject(auth) // Pass auth down so we can sign out
        } else {
            LoginView(auth: auth) // The door, for everyone else
        }
    }
}
