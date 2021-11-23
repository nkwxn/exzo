//
//  SettingsView.swift
//  exzo
//
//  Created by Deven Nathanael on 11/11/21.
//

import SwiftUI

struct SettingsView: View {
    var profileImage: String
    var profileName: String
    
    @State var alertDeleteAccountShown: Bool = false
    @State var alertSignOutShown:Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                ProfileHeaderView(profileImage: profileImage, profileName: profileName)
                    .padding(.bottom)
                List {
                    Section(header: Text("REMINDER")) {
                        
                        NavigationLink {
                            SetReminderView()
                        } label: {
                            SettingRowView(settingIcon: "timer", settingTitle: "Set Reminder")
                        }
                    }
                    
                    Section(header: Text("LANGUAGE")) {
                        NavigationLink {
//                            SetReminderView()
                        } label: {
                            SettingRowView(settingIcon: "globe", settingTitle: "Language")
                        }
                    }
                    
                    Section(header: Text("LEGAL MATTERS")) {
                        NavigationLink {
//                            SetReminderView()
                        } label: {
                            SettingRowView(settingIcon: "lock", settingTitle: "Privacy Policy")
                        }
                        NavigationLink {
//                            SetReminderView()
                        } label: {
                            SettingRowView(settingIcon: "exclamationmark.triangle", settingTitle: "Terms and Conditions")
                        }
                    }
                    
                    Section(header: Text("OTHERS")) {
                        NavigationLink {
                            SetReminderView()
                        } label: {
                            SettingRowView(settingIcon: "star", settingTitle: "Rate our App")
                        }
                        NavigationLink {
                            SetReminderView()
                        } label: {
                            SettingRowView(settingIcon: "questionmark.circle", settingTitle: "Frequently Asked Questions")
                        }
                        NavigationLink {
                            SetReminderView()
                        } label: {
                            SettingRowView(settingIcon: "phone", settingTitle: "Contact Us")
                        }
                        Button {
                            alertDeleteAccountShown.toggle()
                        } label: {
                            SettingRowView(settingIcon: "trash", settingTitle: "Delete Account", showChevron: true)
                        }
//                        .alert(isPresented: $alertDeleteAccountShown, TextAlert(title: "Delete Account" ,message:"Are you sure you want to delete your account?") {
//                            .alert(isPresented: $alertDeleteAccountShown, TextAlert(title: "Delete Account" ,message: "Are you sure want to sign out now?") {_ in
//                                Button("Sign Out", role: .destructive) {}
//                                Button("Cancel", role: .cancel) {}
//                            })
//                        })
                        Button {
                            alertSignOutShown.toggle()
                        } label: {
                            SettingRowView(settingIcon: "arrowshape.turn.up.backward", settingTitle: "Sign Out", showChevron: true)
                        }
//                        .alert(isPresented: $alertSignOutShown, TextAlert(title: "Sign Out" ,message: "Are you sure want to sign out now?") {_ in
//                            Button("Sign Out", role: .destructive) {}
//                            Button("Cancel", role: .cancel) {}
//                        })
                    }
                }
                .cornerRadius(30)
                .edgesIgnoringSafeArea(.bottom)
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarHidden(true)
        }
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(profileImage: "pp_004", profileName: "Regina George")
    }
}
