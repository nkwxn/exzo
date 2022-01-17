//
//  SetReminderViewModel.swift
//  exzo
//
//  Created by Deven Nathanael on 23/11/21.
//

import Foundation

class SetReminderViewModel: ObservableObject {
    
    @Published var reminders: [Reminder] = [] {
        didSet {
            UDHelper.sharedUD.saveReminders(reminders: reminders)
        }
    }
    
    @Published var isAddReminder: Bool = false
    @Published var isEditReminder: Bool = false
    
    init() {
        reminders = UDHelper.sharedUD.getReminders()
    }
    
    func deleteReminder(id: UUID) {
        reminders.removeAll {
            $0.id == id
        }
    }
    
    func deleteReminder(at offsets: IndexSet) {
        reminders.remove(atOffsets: offsets)
        
    }
    
    func addReminder(dateAndTime: Date) {
        let newReminder = Reminder(dateAndTime: dateAndTime)
        reminders.append(newReminder)
    }
    
    func editReminder(id: UUID) {
    
    }
}
