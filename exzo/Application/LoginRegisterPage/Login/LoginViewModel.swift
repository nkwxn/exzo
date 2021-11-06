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
    
    // Alert (please wait and error)
    @Published var showLoading: Bool = false
    @Published var showErrorAlert: Bool = false
    @Published var errorText: String = ""
    
    // Pushing navigation if nickname is not set or open full screen modal to
    @Published var pushNavigation: Bool = false
    @Published var openPage: Bool = false
    
    func loginButtonPressed() {
        // set showloading into true
        if email.isEmpty || password.isEmpty {
            self.errorText = "Please fill all of the fields"
            
            self.showErrorAlert.toggle()
        } else {
            self.showLoading.toggle()
            
            CKHelper.shared.login(email: email, pwd: password) { result in
                do {
                    let account = try result.get()
                    guard let recID = account.recordID else { return }
                    // save to UD
                    UDHelper.sharedUD.createUD(key: UDKey.loginUserID.rawValue, value: recID)
                    if account.nickName == nil && account.picThumb == nil {
                        // push navigation ke change nickname
                        DispatchQueue.main.async {
                            self.pushNavigation = true
                        }
                    } else {
                        // buka tab bar container (gimanapun caranya, trs simpan di ud ID nya)
                        DispatchQueue.main.async {
                            self.openPage = true
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.showLoading = false
                        if let error = error as? AccountError {
                            self.errorText = error.getDescription()
                        } else {
                            self.errorText = error.localizedDescription
                        }
                        self.showErrorAlert.toggle()
                    }
                }
            }
        }
    }
    
    func dismissError() {
        self.showErrorAlert = false
    }
}
