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
                        .foregroundColor(Color("accent_antique"))
                        .frame(width: 347, height: 201, alignment: .center)
                    WeatherView()
                        .frame(width: 347, height: 201, alignment: .center)
                }
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
