//
//  Date+extension.swift
//  exzo
//
//  Created by Nicholas on 29/11/21.
//

import Foundation

extension Date {
    public func setHour(h hour: Int, m minute: Int = 0) -> Date {
        let calendar: Calendar = Calendar.current
        let dateComponents: DateComponents = calendar.dateComponents(in: TimeZone.current, from: self)
        guard let year: Int = dateComponents.year else { return Date() }
        guard let month: Int = dateComponents.month else { return Date() }
        guard let day: Int = dateComponents.day else { return Date() }
        let componentsAtChangedTime: DateComponents = DateComponents(
            calendar: nil, timeZone: TimeZone.current, era: nil,
            year: year, month: month, day: day,
            hour: hour, minute: minute, second: 0, nanosecond: 0,
            weekday: nil, weekdayOrdinal: nil, quarter: nil,
            weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil
        )
        return calendar.date(from: componentsAtChangedTime) ?? Date()
    }
}
