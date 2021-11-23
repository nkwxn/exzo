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
    @State var isAddingJournal = false
    @State var isOpen = false
    @ObservedObject private var calendarModel = CalendarModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                JournalNavBarView(twoColumnsNavBar: false, title: "Skin Journal", subtitle: nil, showButton: .addButton) {
                    self.isAddingJournal.toggle()
                }
                .aspectRatio(contentMode: .fit)
                
                ScrollView {
                    LazyVStack(alignment: .center, spacing: 0, pinnedViews: [.sectionHeaders]) {
                        WeatherView()
                            .frame(width: UIScreen.main.bounds.width)
                            .padding(.bottom, 20)
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
                                            isOpen.toggle()
                                        }
                                    NavigationLink(destination: JournalDetailView(journal: $1), isActive: $isOpen) {
                                    }.opacity(0)
                                    
                                }
                            }
                        } header: {
                            ZStack(alignment: .center) {
                                Color.white
                                    .ignoresSafeArea(.all, edges: .top)
                                CalendarHeader(selectedDate: $calendarModel.selectedDate, currentPage: $calendarModel.currentPage)
                                HStack {
                                    Text("Skin History")
                                        .font(Lexend(.headline).getFont().bold())
                                    Spacer()
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
                .navigationBarHidden(true)
                .navigationTitle("Skin Journal")
            }
        }
    }
}

struct MySkinView_Previews: PreviewProvider {
    static var previews: some View {
        MySkinView()
    }
}
