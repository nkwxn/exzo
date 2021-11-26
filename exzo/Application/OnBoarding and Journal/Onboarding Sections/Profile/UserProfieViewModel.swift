//
//  UserProfieViewModel.swift
//  exzo
//
//  Created by Nicholas on 22/11/21.
//

import Foundation

class UserProfileViewModel: ObservableObject {
    let category: ProfileCategory
    
    var arrLoc = 0
    var imageName: [String]
    @Published var selectedPic: String
    @Published var myNickName = ""
    @Published var ageInt = "10"
    
    @Published var profileName: String = ""
    
    @Published var userConcern = UDHelper.sharedUD.getTriggers()
    
    init(_ category: ProfileCategory) {
        self.category = category
        switch category {
        case .child:
            imageName = ["KidsB", "KidsG"]
        case .adult:
            imageName = ["Man", "Woman", "Boy", "Girl"]
        }
        selectedPic = imageName[arrLoc]
        print(imageName.count)
    }
    
    func shuffleImage() {
        if arrLoc < imageName.count - 1 {
            arrLoc += 1
        } else {
            arrLoc = 0
        }
        selectedPic = imageName[arrLoc]
    }
    
    func saveData() {
        UDHelper.sharedUD.createUD(key: UDKey.userType.rawValue, value: category.rawValue)
        UDHelper.sharedUD.createUD(key: UDKey.userName.rawValue, value: myNickName)
        UDHelper.sharedUD.createUD(key: UDKey.profilePicture.rawValue, value: selectedPic)
        UDHelper.sharedUD.createUD(key: UDKey.childAge.rawValue, value: ageInt)
    }
}
