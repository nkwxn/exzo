//
//  LoginViewModel.swift
//  Atemis
//
//  Created by Nicholas on 01/11/21.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    func loginButtonPressed(completion: @escaping (Result<NewUserAccount, Error>) -> Void) {
        CKHelper.shared.login(email: email, pwd: password) { result in
            
        }
    }
    
}
