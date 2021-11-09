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
        calendar.appearance.headerTitleColor = .brown //warna month
        calendar.appearance.selectionColor = UIColor(red: 150, green: 0, blue: 0, alpha: 0.5) //warna kalo choose date
        calendar.appearance.titleSelectionColor = UIColor.brown
        calendar.appearance.titleTodayColor = .white //warna tanggal today
        calendar.appearance.weekdayTextColor = .black //warna harinya
        calendar.appearance.todayColor = .brown //warna buletan today
        calendar.appearance.titlePlaceholderColor = .white
        
        calendar.dataSource = context.coordinator
        calendar.delegate = context.coordinator
        
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
                return .systemOrange
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
