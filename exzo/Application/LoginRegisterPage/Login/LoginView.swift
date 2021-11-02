//
//  LoginView.swift
//  Atemis
//
//  Created by Nicholas on 01/11/21.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            ExzoTextField("Email", input: $viewModel.email, style: .emailTextField)
            ExzoTextField("Password", input: $viewModel.password, style: .pwdTextField)
            Button("Log in") {
                // TODO: Masukin logic, seperti save ke user defaults
                viewModel.loginButtonPressed { result in
                    
                }
            }
            .buttonStyle(ExzoButtonStyle(type: .primary))
            HStack {
                Text("Don't have account?")
                NavigationLink("Sign up here") {
                    SignUpView()
                }
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Sign Up")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
