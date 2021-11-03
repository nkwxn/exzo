//
//  SignUpViewModel.swift
//  Atemis
//
//  Created by Nicholas on 01/11/21.
//

import Foundation

class SignUpViewModel: ObservableObject {
    // Text Field
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    // Alert (please wait and error)
    @Published var showLoading: Bool = false
    @Published var showErrorAlert: Bool = false
    @Published var errorText: String = ""
    
    // Pushing navigation to set nickname
    @Published var pushNavigation = false
    
    init() {
        UDHelper.sharedUD.defaults.removeObject(forKey: UDKey.loginUserID.rawValue)
    }
    
    func signUpButtonClicked() {
        let newAccount = NewUserAccount(fName: firstName, lName: lastName, email: email, pwd: password)
        
        /* TODO: Tambahin:
            - validasi email (ada simbol @ di tengah dan . bbrp karakter setelah @),
            - validasi password (password 8 char, Kapital, kecil, simbol)
         */
        let fNameValid = self.isValidName(firstName)
        let lNameValid = self.isValidName(lastName)
        let emailValid = self.isValidEmail(email)
        let pwdValid = self.isValidPassword(password)
        
        if fNameValid && lNameValid && emailValid && pwdValid {
            self.showLoading.toggle()
            CKHelper.shared.signUpNewUser(
                newAcc: newAccount
            ) { result in
                DispatchQueue.main.async {
                    self.showLoading.toggle()
                    do {
                        let user = try result.get()
                        // if sign up successful
                        if let safeUserID = user.recordID {
                            // save to user default
                            UDHelper.sharedUD.createUD(key: UDKey.loginUserID.rawValue, value: (safeUserID as NSObject))
                            self.pushNavigation = true
                        }
                    } catch {
                        self.errorText = error.localizedDescription
                        print(error.localizedDescription)
                        DispatchQueue.main.async {
                            self.showErrorAlert = true
                        }
                    }
                }
            }
        } else {
            var errorText = "Please check all fields"
            if !pwdValid {
                errorText += "\nPassword must contain uppercase letters, lowercase letters, numbers, and symbols"
            }
            self.errorText = errorText
            self.showErrorAlert = true
        }
        
        
    }
    
    func dismissError() {
        self.showErrorAlert = false
    }
    
    // MARK: - Form validation
    func isValidName(_ name: String) -> Bool {
        let nameRegex = "[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,.'-]+"
        let namePred = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return namePred.evaluate(with: name)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let pwdRegex = "(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]).{8}"
        let pwdPred = NSPredicate(format: "SELF MATCHES %@", pwdRegex)
        return pwdPred.evaluate(with: password)
    }
}
