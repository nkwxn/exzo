//
//  SignUpView.swift
//  Atemis
//
//  Created by Nicholas on 01/11/21.
//

import SwiftUI

struct SignUpView: View {
    @StateObject var viewModel = SignUpViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 20) {
                ExzoTextField("First name", input: $viewModel.firstName)
                ExzoTextField("Last name", input: $viewModel.lastName)
                ExzoTextField("Email", input: $viewModel.email, style: .emailTextField)
                ExzoTextField("Password", input: $viewModel.password, style: .pwdTextField)
                NavigationLink(destination: SetNicknameView(), isActive: $viewModel.pushNavigation) {
                    EmptyView()
                }.hidden()
                .alert("Error", isPresented: $viewModel.showErrorAlert) {
                    Button("OK", role: .cancel, action: viewModel.dismissError)
                } message: {
                    Text(viewModel.errorText)
                }
                if viewModel.showLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                } else {
                    Button("Sign up", action: viewModel.signUpButtonClicked)
                        .buttonStyle(ExzoButtonStyle(type: .primary))
                }
                HStack(spacing: 0) {
                    Text("Have account? ")
                    NavigationLink("Log in here") {
                        LoginView()
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Sign Up")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
