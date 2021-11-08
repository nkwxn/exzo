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
                Text("Weather")
                CalendarView(dateSelected: $calendarModel.selectedDate, pageCurrent: $calendarModel.currentPage)
                    .frame(width: 300, height: 250, alignment: .init(horizontal: .center, vertical: .center))
                Button("+ Add Journal") {
                    isAddingJournal = true
                }
                .offset(y: -150)
                Text("Coba")
                Text("Journal List")
            }
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
