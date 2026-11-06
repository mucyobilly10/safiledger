//
//  LoginView.swift
//  SafiLedger
//
//  Created by billy Auca on 29/10/2026.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var auth: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("💳 SafiLedger").font(.largeTitle).bold()
            Text("The business payments brain").foregroundColor(.gray)

            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .keyboardType(.emailAddress)

            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)

            if !errorMessage.isEmpty {
                Text(errorMessage).foregroundColor(.red).font(.caption)
            }

            Button("Sign In") {
                if email.isEmpty || password.isEmpty {
                    errorMessage = "Please fill in all fields"
                } else {
                    auth.signIn(email: email, password: password)
                }
            }
            .buttonStyle(.borderedProminent)
            .padding(.top)

            Button("Create an account") {
                if email.isEmpty || password.isEmpty {
                    errorMessage = "Please fill in all fields"
                } else {
                    auth.signUp(email: email, password: password)
                }
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}
