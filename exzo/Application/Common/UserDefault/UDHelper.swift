//
//  UDHelper.swift
//  Atemis
//
//  Created by Deven Nathanael on 01/11/21.
//

import Foundation
enum UDKey: String {
    case loginUserID
    case newUser
    case triggeredBodyParts

    case reminders
    
    // MARK: - Addition from Nic (Profile)
    case userName = "uName"
    case childAge = "age"
    case profilePicture = "pfp"
    case userType = "userProf"
    
    // MARK: - Addition for saving collection
    case userSkinPart = "skinPart"
}

class UDHelper {
    static let sharedUD = UDHelper()
    
    let defaults = UserDefaults.standard
    
    func createUD(key: String, value: Any) {
        defaults.setValue(value, forKey: key)
    }
    
    func isNewUser() -> Bool {
        defaults.bool(forKey: UDKey.newUser.rawValue)
    }
    
    // set not new user anymore
    func setNewUser() {
        defaults.setValue(true, forKey: UDKey.newUser.rawValue)
    }
    
    // Get array of triggers
    func getTriggers() -> [String] {
        guard let skinCond = defaults.object(forKey: UDKey.userSkinPart.rawValue) as? [String] else { return [] }
        return skinCond
    }
    
    // get the profile picture / user profile
    func getPFP() -> String {
        let pfp = defaults.string(forKey: UDKey.profilePicture.rawValue) ?? "KidsB"
        return pfp
    }
    
    func getName() -> String {
        let name = defaults.string(forKey: UDKey.userName.rawValue) ?? "Regina George"
        return name
    }
}
