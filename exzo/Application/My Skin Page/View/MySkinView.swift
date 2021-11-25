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
    @StateObject var journalViewModel = JournalViewModel()
    @State var isOpeningSettings = false
    @State var isAddingJournal = false
    @State var isOpeningDetail = false
    @ObservedObject private var calendarModel = CalendarModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                JournalNavBarView(twoColumnsNavBar: false, title: "Skin Journal", subtitle: nil, showButton: .settingsButton) {
                    self.isOpeningDetail.toggle()
                    print("\(self.isOpeningSettings)")
                }
                .aspectRatio(contentMode: .fit)
                
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
                        
                        LazyVStack(alignment: .center, spacing: 0, pinnedViews: [.sectionHeaders]) {
                            WeatherView()
                                .frame(width: UIScreen.main.bounds.width)
                            Section {
                                if journalViewModel.journals.isEmpty {
                                    ZStack {
                                        Color(uiColor: .systemGray5)
                                            .cornerRadius(15)
                                        Text("No skin history at the moment")
                                            .foregroundColor(.gray)
                                            .padding()
                                    }
                                    .padding(.horizontal)
                                } else {
                                    ForEach(Array(journalViewModel.journals.enumerated()), id: \.0) {
                                        JournalRowView(journal: $1)
                                            .padding(.horizontal)
                                            .padding(.vertical, 14)
                                            .onTapGesture {
                                                isOpeningDetail.toggle()
                                            }
                                            .background(Color.white)
                                        NavigationLink(destination: JournalDetailView(journal: $1), isActive: $isOpeningDetail) {
                                        }.opacity(0)
                                    }
                                }
                            } header: {
                                ZStack(alignment: .bottom) {
                                    Color.white
                                        .ignoresSafeArea(.all, edges: .top)
                                        .cornerRadius(radius: 30, corners: .topLeft)
                                        .cornerRadius(radius: 30, corners: .topRight)
                                    CalendarHeader(selectedDate: $calendarModel.selectedDate, currentPage: $calendarModel.currentPage)
                                    
                                    VStack(alignment: .leading, spacing: 20) {
                                        Button {
                                            isAddingJournal = true
                                        } label: {
                                            Image(systemName: "plus")
                                            Text("Add Journal")
                                        }.buttonStyle(ExzoButtonStyle(type: .primary))
                                        Text("Skin History")
                                            .font(Lexend(.headline).getFont().bold())
                                    }
                                    .padding()
                                }
                            }
                            Divider()
                        }
                        .sheet(isPresented: $isAddingJournal) {
                            AddJournalView()
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
