//
//  ExzoAppContainer.swift
//  exzo
//
//  Created by Nicholas on 04/11/21.
//

import SwiftUI

struct ExzoAppContainer: View {
    
    init() {
        print(UDHelper.sharedUD.defaults.string(forKey: UDKey.loginUserID.rawValue) ?? "kosong")
    }
    
    var body: some View {
        if UDHelper.sharedUD.defaults.string(forKey: UDKey.loginUserID.rawValue) == nil {
            PreOnboardingView()
        } else {
            if UDHelper.sharedUD.isNewUser() {
                SetNicknameView()
            } else {
                TabContainer()
            }
        }
    }
}

struct ExzoAppContainer_Previews: PreviewProvider {
    static var previews: some View {
        ExzoAppContainer()
    }
}
