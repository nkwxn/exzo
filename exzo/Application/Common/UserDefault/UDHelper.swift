//
//  UDHelper.swift
//  Atemis
//
//  Created by Deven Nathanael on 01/11/21.
//

import Foundation
import Combine

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
    
    // MARK: - To save what kind of concern (product, etc)
    case userSkinPart = "skinPart"
}

class UDHelper {
    static let sharedUD = UDHelper()
        
    let defaults = UserDefaults.standard
    
    @Published var reminders: [Reminder] = [] {
        didSet {
            saveReminders(reminders: reminders)
        }
    }
    
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
    
    func saveReminders(reminders: [Reminder]) {
        if let encodedData = try? JSONEncoder().encode(reminders) {
            createUD(key: UDKey.reminders.rawValue, value: encodedData)
        }
    }
    
    func getReminders() -> [Reminder] {
        guard
            let data = defaults.data(forKey: UDKey.reminders.rawValue),
            let savedReminders = try? JSONDecoder().decode([Reminder].self, from: data)
        else { return [] }
        
        return savedReminders
    }
    
    func removeAllReminder() {
        defaults.removeObject(forKey: UDKey.reminders.rawValue)
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
    
    // Reactive Edit Username
    func createProfile(name: String, age: String, pic: String) {
        defaults.userName = name
        defaults.userAge = age
        defaults.userPFP = pic
    }
    
    // PFP, Name, and Age as a Publisher in Combine
    func subsName(receiveVal: @escaping ((String) -> Void)) -> AnyCancellable {
        defaults.publisher(for: \.userName)
            .eraseToAnyPublisher()
            .sink(receiveValue: receiveVal)
    }
    
    func subsAge(receiveVal: @escaping ((String) -> Void)) -> AnyCancellable {
        defaults.publisher(for: \.userAge)
            .eraseToAnyPublisher()
            .sink(receiveValue: receiveVal)
    }
    
    func subsPFP(receiveVal: @escaping ((String) -> Void)) -> AnyCancellable {
        defaults.publisher(for: \.userPFP)
            .eraseToAnyPublisher()
            .sink(receiveValue: receiveVal)
    }
    
    func subsConcern(receiveVal: @escaping (([String]) -> Void)) -> AnyCancellable {
        defaults.publisher(for: \.userConcern)
            .eraseToAnyPublisher()
            .sink(receiveValue: receiveVal)
    }
    
    func getConcern() -> [String] {
        let concerns = defaults.userConcern
        return concerns
    }
    
    func setConcern(_ conc: [String]) {
        defaults.userConcern = conc
    }
}

extension UserDefaults {
    @objc var userPFP: String {
        get {
            return string(forKey: UDKey.profilePicture.rawValue) ?? ""
        }
        set {
            set(newValue, forKey: UDKey.profilePicture.rawValue)
        }
    }
    
    @objc var userName: String {
        get {
            return string(forKey: UDKey.userName.rawValue) ?? ""
        }
        set {
            set(newValue, forKey: UDKey.userName.rawValue)
        }
    }
    
    @objc var userAge: String {
        get {
            return string(forKey: UDKey.childAge.rawValue) ?? ""
        }
        set {
            set(newValue, forKey: UDKey.childAge.rawValue)
        }
    }
    
    @objc var userConcern: [String] {
        get {
            return stringArray(forKey: UDKey.userSkinPart.rawValue) ?? [String]()
        }
        set {
            set(newValue, forKey: UDKey.userSkinPart.rawValue)
        }
    }
}
