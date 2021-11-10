//
//  CalendarViewModel.swift
//  exzo
//
//  Created by Daniella Stefani on 10/11/21.
//

import Foundation

class CalendarViewModel: ObservableObject {
    var calendarData = CalendarModel()
    
    func prevWeek() {
        self.calendarData.currentPage = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: self.calendarData.currentPage)!
    }
    
    func nextWeek() {
        self.calendarData.currentPage = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: self.calendarData.currentPage)!
    }
}
