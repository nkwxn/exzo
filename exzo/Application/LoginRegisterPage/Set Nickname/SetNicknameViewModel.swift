//
//  SetNicknameViewModel.swift
//  exzo
//
//  Created by Nicholas on 03/11/21.
//

import Foundation
import CloudKit

class SetNicknameViewModel: ObservableObject {
    @Published var selectedPic = ""
    @Published var myNickName = ""
    
    func shuffleImage() {
        print("Image should be shuffled")
    }
    
    func viewOnAppear() {
        // Set user default onboarding done to false
        UDHelper.sharedUD.createUD(key: UDKey.newUser.rawValue, value: true)
    }
    
    func doneButtonPressed() {
        guard let recordID = UDHelper.sharedUD.defaults.object(forKey: UDKey.loginUserID.rawValue) as? CKRecord.ID else {
            print("Error: \(CKError.recordIDFailure)")
            return
        }
        
        CKHelper.shared.setNickname(userID: recordID, nickName: myNickName, picKey: selectedPic) { result in
            
        }
    }
}
