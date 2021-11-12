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
                .frame(width: 300, height: 250, alignment: .init(horizontal: .center, vertical: .center))
            
            Button { self.currentPage = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: self.currentPage)!
            } label: {
                Image(systemName: "chevron.right")
            }
            .frame(height: 118, alignment: .top)
        }
        
    }
}

struct NewMySkin: View {
    @State var journalViewModel = JournalViewModel()
    @State var isAddingJournal = false
    @ObservedObject private var calendarModel = CalendarModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                // Header view needs to be pinned on the top

                LazyVStack(alignment: .center, spacing: 10, pinnedViews: [.sectionHeaders]) {
                    Section {
                        // Content
                        Button {
                            isAddingJournal = true
                        } label: {
                            Image(systemName: "plus")
                            Text("Add Journal")
                        }.buttonStyle(ExzoButtonStyle(type: .primary))
                            .padding()
//                            .offset(y: -165)
                        
                        ForEach(Array(journalViewModel.journals.enumerated()), id: \.0) {
                            JournalRowView(journal: $1)
                        }
                    } header: {
                        CalendarHeader(selectedDate: $calendarModel.selectedDate, currentPage: $calendarModel.currentPage)
                    }
                }
                .sheet(isPresented: $isAddingJournal) {
                    AddJournalView()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct MySkinView: View {
    @State var journalViewModel = JournalViewModel()
    @State var isAddingJournal = false
    @ObservedObject private var calendarModel = CalendarModel()
    
    var body: some View {
        NavigationView {
            VStack {
                WeatherView()
                    .frame(width: 309, alignment: .center)
                HStack {
                    Button() { self.calendarModel.currentPage = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: self.calendarModel.currentPage)!
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    .frame(height: 118, alignment: .top)
                    
                    CalendarView(dateSelected: $calendarModel.selectedDate, pageCurrent: $calendarModel.currentPage)
                        .frame(width: 300, height: 250, alignment: .init(horizontal: .center, vertical: .center))
                    
                    Button() { self.calendarModel.currentPage = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: self.calendarModel.currentPage)!
                    } label: {
                        Image(systemName: "chevron.right")
                    }
                    .frame(height: 118, alignment: .top)
                }
                
                Button {
                    isAddingJournal = true
                } label: {
                    Image(systemName: "plus")
                    Text("Add Journal")
                }.buttonStyle(ExzoButtonStyle(type: .primary))
                    .padding()
                    .offset(y: -150)
                
                List {
                    ForEach(Array(journalViewModel.journals.enumerated()), id: \.0) {
                        JournalRowView(journal: $1)
                    }
                    .onDelete(perform: journalViewModel.deleteItem)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .aspectRatio(contentMode: .fill)
                }
                Text("Journal List")
            }
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $isAddingJournal) {
            AddJournalView()
        }
        
    }
}

struct MySkinView_Previews: PreviewProvider {
    static var previews: some View {
        MySkinView()
    }
}
