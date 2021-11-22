//
//  UDHelper.swift
//  Atemis
//
//  Created by Deven Nathanael on 01/11/21.
//

import Foundation

enum UDKey: String {
    case loginUserID = "loginUserID"
    case newUser = "newUser"
    case triggeredBodyParts = "triggeredBodyParts"
    
    // MARK: - Addition from Nic
    case userName = "name"
    case childAge = "age"
    case profilePicture = "pfp"
}

class UDHelper{
    static let sharedUD = UDHelper()
    
    let defaults = UserDefaults.standard
    
    func createUD(key: String, value: Any){
        defaults.setValue(value, forKey: key)
    }
    
    func isNewUser() -> Bool {
        defaults.bool(forKey: UDKey.newUser.rawValue)
    }
    
    func setNewUser() {
        defaults.setValue(false, forKey: UDKey.newUser.rawValue)
    }    
}
