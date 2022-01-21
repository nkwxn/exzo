//
//  SettingsView.swift
//  exzo
//
//  Created by Deven Nathanael on 11/11/21.
//

import SwiftUI
import MessageUI
import Combine

class SettingsViewModel: ObservableObject {
    @Published var profileImage: String = ""
    @Published var profileName: String = ""
    @Published var profileAge: String = ""
    
    var subs = Set<AnyCancellable>()
    
    init() {
        // User Name
        UDHelper.sharedUD
            .subsName { name in
                self.profileName = name
            }.store(in: &subs)
        
        // User Age
        UDHelper.sharedUD
            .subsAge { age in
                self.profileAge = age
            }.store(in: &subs)
        
        // User Profile Picture
        UDHelper.sharedUD
            .subsPFP { pfp in
                self.profileImage = pfp
            }.store(in: &subs)
    }
}

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.scenePhase) var scenePhase
    
    @State var alertDeleteAccountShown: Bool = false
    @State var alertSignOutShown: Bool = false
    
    @ObservedObject var viewModel = SettingsViewModel()
    
    //    @State var isWriteReview: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                ProfileHeaderView(profileImage: $viewModel.profileImage, profileName: $viewModel.profileName, profileAge: $viewModel.profileAge)
                    .padding(.bottom)
                List {
                    Section {
                        NavigationLink {
                            UserProfileView(
                                category: ProfileCategory(
                                    rawValue: UDHelper.sharedUD
                                        .defaults.string(
                                            forKey: UDKey.userType.rawValue
                                        ) ?? "userProf"
                                ) ?? .adult,
                                update: true
                            )
                        } label: {
                            SettingRowView(settingIcon: "person.crop.circle", settingTitle: "Ubah Nama dan Foto")
                        }
                        NavigationLink {
                            JournalConcernView()
                        } label: {
                            SettingRowView(settingIcon: "bolt", settingTitle: "Ubah Pemicu")
                        }
                    } header: {
                        Text("PROFIL ANDA")
                    }
                    
                    Section(header: Text("PENGINGAT")) {
                        NavigationLink {
                                SetReminderView()
                            } label: {
                                SettingRowView(settingIcon: "timer", settingTitle: "Atur Pengingat")
                            }
                        }
                    
                        Section(header: Text("LAINNYA")) {
    //                        Button {
    //                            isWriteReview.toggle()
    //                        } label: {
    //                            SettingRowView(settingIcon: "star", settingTitle: "Nilai Aplikasi Kami", showChevron: true)
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
                    }
                    Section(header: Text("LAINNYA")) {
                        NavigationLink {
                            
                        } label: {
                            SettingRowView(settingIcon: "questionmark.circle", settingTitle: "Pertanyaan yang Sering Ditanyakan")
                        }
                        NavigationLink {
                            

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
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .active:
                print("Scene is active")
            case .inactive:
                print("Scene is inactive")
            case .background:
                print("Scene is in background")
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
