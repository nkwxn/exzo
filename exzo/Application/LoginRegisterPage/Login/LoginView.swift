//
//  LoginView.swift
//  Atemis
//
//  Created by Nicholas on 01/11/21.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
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
                Button("Log in", action: viewModel.loginButtonPressed)
                    .buttonStyle(ExzoButtonStyle(type: .primary))
            }
            HStack {
                Text("Don't have account?")
                NavigationLink("Sign up here") {
                    SignUpView()
                }
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Log In")
        .navigationBarTitleDisplayMode(.inline)
        .fullScreenCover(isPresented: $viewModel.openPage, onDismiss: nil) {
            TabContainer()
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
