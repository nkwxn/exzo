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
    
    @Published var showOnboarding = false
    
    func shuffleImage() {
        print("Image should be shuffled")
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