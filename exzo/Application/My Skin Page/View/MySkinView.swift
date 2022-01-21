//
//  MySkinPage.swift
//  exzo
//
//  Created by Daniella Stefani on 04/11/21.
// 

import SwiftUI

struct CalendarHeader: View {
    @Binding var selectedDate: Date
    @Binding var currentPage: Date
    
    var body: some View {
        // Headings
        HStack {
            Button { self.currentPage = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: self.currentPage)!
            } label: {
                Image(systemName: "chevron.left")
            }
            .frame(height: 118, alignment: .top)
            
            CalendarView(dateSelected: $selectedDate, pageCurrent: $currentPage)
                .frame(width: 300, height: 225, alignment: .init(horizontal: .center, vertical: .center))
            
            Button { self.currentPage = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: self.currentPage)!
            } label: {
                Image(systemName: "chevron.right")
            }
            .frame(height: 118, alignment: .top)
        }
        
    }
}

struct MySkinView: View {
    @ObservedObject var journalViewModel = JournalViewModel()
    @State var isOpeningSettings = false
    @State var isAddingJournal = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                JournalNavBarView(twoColumnsNavBar: false, title: "Jurnal", subtitle: nil, showButton: .settingsButton) {
                    self.isOpeningSettings.toggle()
                    print("\(self.isOpeningSettings)")
                }
                .aspectRatio(contentMode: .fit)
                .sheet(isPresented: $isOpeningSettings) {
                    // onDismiss
                } content: {
                    SettingsView(profileImage: UDHelper.sharedUD.getPFP(), profileName: UDHelper.sharedUD.getName())
                }
                
                ScrollView {
                    ZStack {
                        GeometryReader {reader in
                            Image("NavBar-Background")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .offset(y: -reader.frame(in: .global).minY)
                                .frame(width: UIScreen.main.bounds.width, height: reader.frame(in: .global).minY > 0 ? reader.frame(in: .global).minY + 10 : 10)
                        }
                        .frame(height: 10)
                        /*
                         Buat nanti kalo mau refactoring view
                        List {
                            Section {
                                // Content
                            } header: {
                                Text("Dajjal")
                            }
                        }
                         */
                        LazyVStack(alignment: .center, spacing: 0, pinnedViews: [.sectionHeaders]) {
                            WeatherView()
                                .frame(width: UIScreen.main.bounds.width)
                            Section {
                                if journalViewModel.filteredJournal.isEmpty {
                                    ZStack {
                                        Color(uiColor: .systemGray5)
                                            .cornerRadius(15)
                                        Text("Belum ada jurnal saat ini. Tambahkan jurnal Anda dengan menekan tombol \"+ Tambahkan Jurnal\"di atas.")
                                            .foregroundColor(.gray)
                                            .padding()
                                    }
                                    .padding(.horizontal)
                                } else {
                                    ForEach($journalViewModel.filteredJournal, id: \.self) { journal in
                                        NavigationLink {
                                            JournalDetailView(journal: journal.wrappedValue)
                                        } label: {
                                            JournalRowView(journal: journal.wrappedValue)
                                                .padding(.horizontal)
                                                .padding(.vertical, 14)
                                                .background(Color.white)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                        .contextMenu {
                                            Button(role: .destructive) {
                                                print("Delete \(journal.wrappedValue)")
                                            } label: {
                                                Image(systemName: "trash")
                                                Text("Hapus Jurnal")
                                            }

                                        }
                                    }
                                }
                            } header: {
                                ZStack(alignment: .bottom) {
                                    Color.white
                                        .ignoresSafeArea(.all, edges: .top)
                                        .cornerRadius(radius: 30, corners: .topLeft)
                                        .cornerRadius(radius: 30, corners: .topRight)
                                    CalendarHeader(selectedDate: $journalViewModel.selectedDate, currentPage: $journalViewModel.currentPage)
                                    
                                    VStack(alignment: .leading, spacing: 20) {
                                        Button {
                                            isAddingJournal = true
                                        } label: {
                                            Image(systemName: "plus")
                                            Text("Tambahkan Jurnal")
                                        }.buttonStyle(ExzoButtonStyle(type: .primary))
                                        Text("Riwayat Pengisian Jurnal")
                                            .font(Lexend(.headline).getFont().bold())
                                    }
                                    .padding()
                                }
                            }
                            Divider()
                        }
                        .sheet(
                            isPresented: $isAddingJournal
                        ) {
                            SkinConditionJournalView(
                                jourVM: JournalInputViewModel(
                                    ProfileCategory(
                                        rawValue: UDHelper.sharedUD.defaults.string(forKey: UDKey.userType.rawValue) ?? "userProf"
                                    ) ?? .adult,
                                    mode: .create
                                )
                            ).environment(\.modalMode, $isAddingJournal)
                                .interactiveDismissDisabled(true)
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .navigationTitle("Skin Journal")
        }
    }
}

struct MySkinView_Previews: PreviewProvider {
    static var previews: some View {
        MySkinView()
    }
}
