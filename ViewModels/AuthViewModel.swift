//
//  AuthViewModel.swift
//  SafiLedger
//
//  Created by billy Auca on 29/10/2026.
//



import Foundation
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var user: FirebaseAuth.User? // nil means nobody is signed in

    init() {
        // Firebase tells us whenever someone signs in or out
        Auth.auth().addStateDidChangeListener { _, user in
            self.user = user
        }
    }

    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            if let error = error { print("Sign up failed: \(error.localizedDescription)") }
        }
    }

    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if let error = error { print("Sign in failed: \(error.localizedDescription)") }
        }
    }

    func signOut() {
        try? Auth.auth().signOut()
    }
}

