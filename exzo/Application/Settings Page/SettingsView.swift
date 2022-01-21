//
//  SettingsView.swift
//  exzo
//
//  Created by Deven Nathanael on 11/11/21.
//

import SwiftUI
import MessageUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.openURL) var openURL
    var profileImage: String
    var profileName: String
    
    @State var alertDeleteAccountShown: Bool = false
    @State var alertSignOutShown: Bool = false
    @State var showAlert: Bool = false
    @State var showMail: Bool = false
   
//    @State var isWriteReview: Bool = false
//    let ig = URL(string: "https://www.instagram.com/exzo.companion/")
    var body: some View {
        NavigationView {
            ZStack{
                VStack {
                    ProfileHeaderView(profileImage: "L0 - \(profileImage)", profileName: profileName)
                        .padding(.bottom)
                    List {
                        /*
                         // Tambah section buat update profile dan concern
                        Section {
                            NavigationLink {
                                
                            } label: {
                                SettingRowView(settingIcon: "person.crop.circle", settingTitle: "Ubah Nama dan Foto")
                            }
                            NavigationLink {
                                
                            } label: {
                                SettingRowView(settingIcon: "bolt", settingTitle: "Ubah Pemicu")
                            }
                        } header: {
                            Text("PROFIL ANDA")
                        }
    */
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
                                FAQView()
                            } label: {
                                SettingRowView(settingIcon: "questionmark.circle", settingTitle: "Pertanyaan yang Sering Ditanyakan")
                            }
                            Button {
                                self.showAlert.toggle()
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
               PopUpWindow(show: $showAlert)
            }
        }
//        .sheet(isPresented: $isWriteReview) {
//            RateView()
//        }
        
//        .sheet(isPresented: $showMail) {
//            MailView(data: $dataMail) { result in
//                print(result)
//            }
//        }

    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(profileImage: "pp_004", profileName: "Regina George")
    }
}
