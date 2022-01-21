//
//  UserProfieViewModel.swift
//  exzo
//
//  Created by Nicholas on 22/11/21.
//

import Combine

class UserProfileViewModel: ObservableObject {
    let category: ProfileCategory
    
    var arrLoc = 0
    var imageName: [String]
    @Published var selectedPic: String = ""
    @Published var myNickName = ""
    @Published var ageInt = ""
    
    @Published var userConcern = UDHelper.sharedUD.getTriggers()
    
    var subs = Set<AnyCancellable>()
    
    init(_ category: ProfileCategory) {
        self.category = category
        
        switch category {
        case .child:
            imageName = ["KidsB", "KidsG"]
        case .adult:
            imageName = ["Man", "Woman", "Boy", "Girl"]
        }
        
        initSubscribers()
        selectedPic = selectedPic.isEmpty ? imageName[arrLoc] : selectedPic
        print(imageName.count)
    }
    
    func initSubscribers() {
        UDHelper.sharedUD.subsName { value in
            self.myNickName = value
        }.store(in: &subs)
        UDHelper.sharedUD.subsAge { value in
            self.ageInt = value
        }.store(in: &subs)
        UDHelper.sharedUD.subsPFP { value in
            self.selectedPic = value
        }.store(in: &subs)
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
        UDHelper.sharedUD.createProfile(name: myNickName, age: ageInt, pic: selectedPic)
    }
}
