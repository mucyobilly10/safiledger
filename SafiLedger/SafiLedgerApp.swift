//
//  SafiLedgerApp.swift
//  SafiLedger
//
//  Created by Intore Auca on 29/10/2026.
//

import SwiftUI
import FirebaseCore

@main
struct SafiLedgerApp: App {
    // Wake Firebase up when the app starts
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            RootView() // Start at the door
        }
    }
}
