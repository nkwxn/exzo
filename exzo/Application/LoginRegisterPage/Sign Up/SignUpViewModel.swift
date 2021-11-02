//
//  SignUpViewModel.swift
//  Atemis
//
//  Created by Nicholas on 01/11/21.
//

import Foundation

class SignUpViewModel: ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    func signUpButtonClicked() {
        let newAccount = NewUserAccount(fName: firstName, lName: lastName, email: email, pwd: password)
        
        CKHelper.shared.signUpNewUser(
            newAcc: newAccount
        ) { <#Result<NewUserAccount, Error>#> in
            <#code#>
        }
    }
}
