//
//  CalendarData.swift
//  FSCalendarTest
//
//  Created by Daniella Stefani on 27/10/21.
//

import SwiftUI

class CalendarModel: ObservableObject {
    @Published var selectedDate: Date = Date()
    @Published var currentPage: Date = Date()
}
