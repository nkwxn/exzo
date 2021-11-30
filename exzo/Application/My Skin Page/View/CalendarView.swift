//
//  CalendarView.swift
//  FSCalendarTest
//
//  Created by Daniella Stefani on 26/10/21.
//

import SwiftUI
import FSCalendar

struct CalendarView: UIViewRepresentable {
    typealias UIViewType = FSCalendar
    
    @Binding var dateSelected: Date
    @Binding var pageCurrent: Date
    
    var calendar = FSCalendar()
    
    var today: Date {
        return Date()
    }
    
    func makeUIView(context: Context) -> FSCalendar {
        calendar.scope = .week
        calendar.appearance.headerDateFormat = "MMM YYYY"
        calendar.appearance.headerMinimumDissolvedAlpha = 0
        calendar.appearance.headerTitleColor = UIColor(Color.copper)
        calendar.appearance.selectionColor = UIColor(Color.antique)
        calendar.appearance.titleSelectionColor = UIColor(Color.copper)
        calendar.appearance.titleTodayColor = UIColor(Color.copper)
        calendar.appearance.weekdayTextColor = .black
        calendar.appearance.todayColor = .clear
        calendar.appearance.titlePlaceholderColor = .white
        
        calendar.dataSource = context.coordinator
        calendar.delegate = context.coordinator
        
        calendar.select(calendar.today)
        
        calendar.locale = NSLocale.init() as Locale
        
        return calendar
    }

    func updateUIView(_ uiView: FSCalendar, context: Context) {
        uiView.setCurrentPage(pageCurrent, animated: true)
    }
    
    func makeCoordinator() -> CalendarView.Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
        var parent: CalendarView
        
        init(_ parent: CalendarView) {
            self.parent = parent
        }
        
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            parent.dateSelected = date
            print(date)
        }
        
        func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
            parent.pageCurrent = calendar.currentPage
        }
        
        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
            if date.removeTimestamp!.compare(Date().removeTimestamp!) == .orderedAscending {
                return .black
            } else if date.removeTimestamp!.compare(Date().removeTimestamp!) == .orderedDescending {
                return .gray
            } else {
                return UIColor(Color.copper)
            }
        }
    }
}

extension Date {
    public var removeTimestamp: Date? {
        guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self)) else {
            return nil
        }
        return date
    }
}
