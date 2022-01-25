//
//  SetReminderViewModel.swift
//  exzo
//
//  Created by Deven Nathanael on 23/11/21.
//

import Foundation
import UserNotifications

class SetReminderViewModel: ObservableObject {
    
    @Published var reminders: [Reminder] = [] {
        didSet {
            UDHelper.sharedUD.saveReminders(reminders: reminders)
        }
    }
    
//    @Published var isEditReminder: Bool = false
    
    init() {
        reminders = UDHelper.sharedUD.getReminders()
    }
    
    func deleteReminder(at offsets: IndexSet) {
        let notificationID = offsets.map { self.reminders[$0].notificationID }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: notificationID)
        reminders.remove(atOffsets: offsets)
        
    }
    
    func addReminder(dateAndTime: Date, notificationID: String) {
        let newReminder = Reminder(dateAndTime: dateAndTime, notificationID: notificationID)
        reminders.append(newReminder)
    }
    
    func editReminder(id: UUID) {
    
    }
}
