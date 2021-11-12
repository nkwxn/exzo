//
//  MySkinPage.swift
//  exzo
//
//  Created by Daniella Stefani on 04/11/21.
//

import SwiftUI

struct MySkinView: View {
    @State var journalViewModel = JournalViewModel()
    @State var isAddingJournal = false
    @ObservedObject private var calendarModel = CalendarModel()
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 19)
                        .foregroundColor(Color.white)
                        .frame(width: 309, alignment: .center)
                        .shadow(color: Color.init(uiColor: UIColor.init(red: 0.45, green: 0.29, blue: 0.22, alpha: 0.2)), radius: 10, x: 2, y: 5)
                    WeatherView()
                        .frame(width: 309, alignment: .center)
                }
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
                
                Button() {
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
            }
        }
        .sheet(isPresented: $isAddingJournal) {
            AddJournalView()
        }
        .navigationBarHidden(true)
        
    }
}

struct MySkinView_Previews: PreviewProvider {
    static var previews: some View {
        MySkinView()
    }
}
