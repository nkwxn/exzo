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
        VStack(spacing: 20) {
            ExzoTextField("First name", input: $viewModel.firstName)
            ExzoTextField("Last name", input: $viewModel.lastName)
            ExzoTextField("Email", input: $viewModel.email, style: .emailTextField)
            ExzoTextField("Password", input: $viewModel.password, style: .pwdTextField)
            Button("Sign up", action: viewModel.signUpButtonClicked)
            .buttonStyle(ExzoButtonStyle(type: .primary))
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
