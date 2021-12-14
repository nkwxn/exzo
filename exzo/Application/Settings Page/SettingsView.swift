//
//  SettingsView.swift
//  exzo
//
//  Created by Deven Nathanael on 11/11/21.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    var profileImage: String
    var profileName: String
    
    @State var alertDeleteAccountShown: Bool = false
    @State var alertSignOutShown: Bool = false
    
//    @State var isWriteReview: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                ProfileHeaderView(profileImage: "L0 - \(profileImage)", profileName: profileName)
                    .padding(.bottom)
                List {
                    Section(header: Text("PENGINGAT")) {
                        
                        NavigationLink {
                            SetReminderView()
                        } label: {
                            SettingRowView(settingIcon: "timer", settingTitle: "Atur Pengingat")
                        }
                    }
                    
                    Section(header: Text("BAHASA")) {
                        NavigationLink {
                            LanguagePageView()
                        } label: {
                            SettingRowView(settingIcon: "globe", settingTitle: "Bahasa")
                        }
                    }
                    
                    /*
                    Section(header: Text("MASALAH HUKUM")) {
                        NavigationLink {
                            PrivacyPolicyView()
                        } label: {
                            SettingRowView(settingIcon: "lock", settingTitle: "Kebijakan Privasi")
                        }
                        NavigationLink {
                            
                        } label: {
                            SettingRowView(settingIcon: "exclamationmark.triangle", settingTitle: "Syarat dan Ketentuan")
                        }
                    }
                     */
                    
                    Section(header: Text("LAINNYA")) {
//                        Button {
//                            isWriteReview.toggle()
//                        } label: {
//                            SettingRowView(settingIcon: "star", settingTitle: "Nilai Aplikasi Kami", showChevron: true)
//                        }
//                        NavigationLink {
////                            SetReminderView()
//                        } label: {
//                            SettingRowView(settingIcon: "questionmark.circle", settingTitle: "Frequently Asked Questions")
//                        }
                        NavigationLink {
                            
                        } label: {
                            SettingRowView(settingIcon: "questionmark.circle", settingTitle: "Pertanyaan yang Sering Ditanyakan")
                        }
                        NavigationLink {

                        } label: {
                            SettingRowView(settingIcon: "phone", settingTitle: "Kontak Kami")
                        }
//                        Button {
//                            alertDeleteAccountShown.toggle()
//                        } label: {
//                            SettingRowView(settingIcon: "trash", settingTitle: "Delete Account", showChevron: true)
//                        }
//                        .alert("Delete Account", isPresented: $alertDeleteAccountShown) {
//                            Button("Cancel", role: .cancel) {}
//                            Button("I'm Sure", role: .destructive) {}
//                        } message: {
//                            Text("Are you sure you want to delete your account?")
//                        }
//
//                        Button {
//                            alertSignOutShown.toggle()
//                        } label: {
//                            SettingRowView(settingIcon: "arrowshape.turn.up.backward", settingTitle: "Sign Out", showChevron: true)
//                        }
//                        .alert("Delete Account", isPresented: $alertSignOutShown) {
//                            Button("Cancel", role: .cancel) {}
//                            Button("Sign Out", role: .destructive) {}
//                        } message: {
//                            Text("Are you sure want to sign out now?")
//                        }
                    }
                }
                .cornerRadius(30)
                .edgesIgnoringSafeArea(.bottom)
            }
            .listStyle(InsetGroupedListStyle())
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .symbolRenderingMode(.hierarchical)
                    }
                    .foregroundColor(Color.white)
                }
            }
//            .navigationTitle("Pengaturan")
            .navigationBarTitleDisplayMode(.inline)
//            .navigationBarHidden(true)
            
        }
//        .sheet(isPresented: $isWriteReview) {
//            RateView()
//        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(profileImage: "pp_004", profileName: "Regina George")
    }
}
