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
    
    @State var showAlert: Bool = false
    
    @ObservedObject var viewModel = SettingsViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                    ProfileHeaderView(profileImage: $viewModel.profileImage, profileName: $viewModel.profileName, profileAge: $viewModel.profileAge)
//                        .padding(.bottom)
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
                            
                            HStack {
                                SettingRowView(settingIcon: "phone", settingTitle: "Kontak Kami")
                                Spacer()
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                self.showAlert.toggle()
                            }
                        }
                    }
                    .cornerRadius(30)
                    .edgesIgnoringSafeArea(.bottom)
                    .padding(.top, 150)
                    .listStyle(InsetGroupedListStyle())
                
                PopUpWindow(show: $showAlert)
            }
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
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
