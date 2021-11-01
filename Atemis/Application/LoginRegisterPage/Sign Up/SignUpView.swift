//
//  SignUpView.swift
//  Atemis
//
//  Created by Nicholas on 01/11/21.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewModel = SignUpViewModel()
    
    var body: some View {
        // TODO: Ubah ke custom text field dan button style
        VStack {
            TextField("First name", text: .constant(""))
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Last name", text: .constant(""))
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Email", text: .constant(""))
                .textFieldStyle(RoundedBorderTextFieldStyle())
            SecureField("Password", text: .constant(""))
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Log in") {
                // TODO: Panggil function buat sign up dari ViewModel, kemudian redirect ke your profile + onboarding
            }
            HStack(spacing: 0) {
                Text("Have account? ")
                NavigationLink("Log in here") {
                    LoginView()
                }
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Sign Up")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
