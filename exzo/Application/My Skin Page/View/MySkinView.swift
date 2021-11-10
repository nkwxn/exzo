//
//  MySkinPage.swift
//  exzo
//
//  Created by Daniella Stefani on 04/11/21.
//

import SwiftUI

struct MySkinView: View {
    @State var journalViewModel = JournalViewModel()
//    @State var calendarViewModel = CalendarViewModel()
    @State var isAddingJournal = false
    @ObservedObject private var calendarModel = CalendarModel()
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 19)
                        .foregroundColor(Color.white)
                        .frame(width: 309, height: 130, alignment: .center)
                        .shadow(color: Color.init(uiColor: UIColor.init(red: 0.45, green: 0.29, blue: 0.22, alpha: 0.2)), radius: 10, x: 2, y: 5)
//                        .shadow(color: Color.init(red: 0.45, green: 0.29, blue: 0.22), radius: 10, x: 2, y: 5)
                    WeatherView()
                        .frame(width: 309, height: 130, alignment: .center)
                }
                HStack {
                    Button(action: { self.calendarModel.currentPage = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: self.calendarModel.currentPage)! }) {
                        Image(systemName: "chevron.left")
                    }
                    .frame(height: 118, alignment: .top)
                    
                    CalendarView(dateSelected: $calendarModel.selectedDate, pageCurrent: $calendarModel.currentPage)
                        .frame(width: 300, height: 250, alignment: .init(horizontal: .center, vertical: .center))
                    
                    Button(action: { self.calendarModel.currentPage = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: self.calendarModel.currentPage)! }) {
                        Image(systemName: "chevron.right")
                    }
                    .frame(height: 118, alignment: .top)
                }
                
                Button("+ Add Journal") {
                    isAddingJournal = true
                } label: {
                    Image(systemName: "plus")
                    Text("Add Journal")
                }.buttonStyle(ExzoButtonStyle(type: .primary))
                    .padding()
                List {
                    ForEach(journalViewModel.journals) {
                        Text("\($0) text")
                    }
                }
                .offset(y: -150)
                Text("Journal List")
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
