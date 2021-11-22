//
//  UserProfieViewModel.swift
//  exzo
//
//  Created by Nicholas on 22/11/21.
//

import Foundation

class UserProfileViewModel: ObservableObject {
    var arrLoc = 0
    var imageName = ["pp_001", "pp_002", "pp_003", "pp_004"]
    @Published var selectedPic = "pp_001"
    @Published var myNickName = ""
    @Published var ageInt = 72
    
    @Published var profileName: String = ""
    @Published var childAge: Int = 10
    
    func shuffleImage() {
        if arrLoc < 3 {
            arrLoc += 1
        } else {
            arrLoc = 0
        }
        selectedPic = imageName[arrLoc]
    }
    
    func saveData(_ category: ProfileCategory) {
        UDHelper.sharedUD.createUD(key: UDKey.userName.rawValue, value: myNickName)
        UDHelper.sharedUD.createUD(key: UDKey.profilePicture.rawValue, value: selectedPic)
        if category == .child {
            UDHelper.sharedUD.createUD(key: UDKey.childAge.rawValue, value: selectedPic)
        }
    }
}
