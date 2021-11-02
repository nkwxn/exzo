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
        // TODO: Ubah style ke custom text field dan button style
        VStack {
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Log in") {
                // TODO: Panggil function buat login dari ViewModel
                viewModel.loginButtonPressed { result in
                    
                }
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
        .navigationTitle("Sign Up")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
