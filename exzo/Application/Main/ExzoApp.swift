//
//  ExzoApp.swift
//  Atemis
//
//  Created by Nicholas on 26/10/21.
//

import SwiftUI

@main
struct ExzoApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @State var loginAlert = false
    @State var isNewUser = false
    
    init() {
         print("Exzo runs")
    }
    
    var body: some Scene {
        
        WindowGroup {
            // MARK: - Bikin sesuai dengan itunya
            TabContainer()
                .preferredColorScheme(.light)
                .font(Avenir.shared.getFont())
                .fullScreenCover(isPresented: $isNewUser) {
                    ChildAdultView()
                        .environment(\.modalMode, $isNewUser)
                }
                .alert("Please sign in your Apple ID to continue", isPresented: $loginAlert) {
                    Button("Open Settings") {
                        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                            return
                        }
                        
                        if UIApplication.shared.canOpenURL(settingsUrl) {
                            UIApplication.shared.open(settingsUrl, options: [:]) { success in
                                print("Settings opened: \(success)")
                            }
                        }
                    }
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
                if !UDHelper.sharedUD.isNewUser() {
                    isNewUser = true
                }
                print(UDHelper.sharedUD.isNewUser())
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
