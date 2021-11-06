//
//  SetNicknameViewModel.swift
//  exzo
//
//  Created by Nicholas on 03/11/21.
//

import Foundation
import CloudKit

class SetNicknameViewModel: ObservableObject {
    var arrLoc = 0
    var imageName = ["pp_001", "pp_002", "pp_003", "pp_004"]
    @Published var selectedPic = "pp_001"
    @Published var myNickName = ""
    
    @Published var showOnboarding = false
    
    func shuffleImage() {
        if arrLoc < 3 {
            arrLoc += 1
        } else {
            arrLoc = 0
        }
        selectedPic = imageName[arrLoc]
    }
    
    func viewOnAppear() {
        // Set user default onboarding done to false
        UDHelper.sharedUD.createUD(key: UDKey.newUser.rawValue, value: true)
    }
    
    func doneButtonPressed() {
        guard let recordID = UDHelper.sharedUD.defaults.string(forKey: UDKey.loginUserID.rawValue) else {
            print("Error: \(CKError.recordIDFailure)")
            return
        }
        
        CKHelper.shared.setNickname(recordID: recordID, nickName: myNickName, picKey: selectedPic) { result in
            do {
                let account = try result.get()
                print("Updating nickname success: \(account)")
                self.showOnboarding.toggle()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
