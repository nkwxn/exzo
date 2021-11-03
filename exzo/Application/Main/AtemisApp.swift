//
//  AtemisApp.swift
//  Atemis
//
//  Created by Nicholas on 26/10/21.
//

import SwiftUI

@main
struct AtemisApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @State var loginAlert = false
    
    init() {
        print("Atemis runs")
    }
    
    var body: some Scene {
        WindowGroup {
            if UDHelper.sharedUD.defaults.string(forKey: UDKey.loginUserID.rawValue) == nil {
                PreOnboardingView()
                    .alert("Please sign in your Apple ID to continue", isPresented: $loginAlert) {
                        Button("Open Settings") {
                            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                                return
                            }
                            
                            if UIApplication.shared.canOpenURL(settingsUrl) {
                                UIApplication.shared.open(settingsUrl, options: [: ]) { success in
                                    print("Settings opened: \(success)")
                                }
                            }
                        }
                    }
            } else {
                SetNicknameView()
            }
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .active:
                print("Active")
                CKCrudOperators.checkiCloud { status, error in
                    switch status {
                    case .noAccount:
                        print("alert please login")
                        self.loginAlert = true
                    default:
                        // continue to app
                        print("Continue to the app")
                    }
                }
            case .inactive:
                print("Inactive")
            case .background:
                print("background")
            @unknown default:
                print("unknown def")
            }
        }
    }
}
