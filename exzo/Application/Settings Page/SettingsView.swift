//
//  SettingsView.swift
//  exzo
//
//  Created by Deven Nathanael on 11/11/21.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            ProfileHeaderView(profileImage: "pp_004", profileName: "Regina George")
                .padding(.bottom)
            List {
                Section(header: Text("REMINDER")) {
                    SettingRowView(settingIcon: "timer", settingTitle: "Set Reminder")
                }
                
                Section(header: Text("LANGUAGE")) {
                    SettingRowView(settingIcon: "globe", settingTitle: "Language")
                }
                
                Section(header: Text("LEGAL MATTERS")) {
                    SettingRowView(settingIcon: "lock", settingTitle: "Privacy Policy")
                    SettingRowView(settingIcon: "exclamationmark.triangle", settingTitle: "Terms and Conditions")
                }
                
                Section(header: Text("OTHERS")) {
                    SettingRowView(settingIcon: "star", settingTitle: "Rate our App")
                    SettingRowView(settingIcon: "questionmark.circle", settingTitle: "Frequently Asked Questions")
                    SettingRowView(settingIcon: "phone", settingTitle: "Contact Us")
                    SettingRowView(settingIcon: "trash", settingTitle: "Delete Account")
                    SettingRowView(settingIcon: "arrowshape.turn.up.backward", settingTitle: "Sign Out")
                    
                }
                
            }
            .cornerRadius(30)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }

}
