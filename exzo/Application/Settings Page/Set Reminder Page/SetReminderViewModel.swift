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
            saveReminders()
        }
    }
    
    init() {
        getReminders()
    }
    
    func getReminders() {
        guard
            let data = UDHelper.sharedUD.defaults.data(forKey: UDKey.reminders.rawValue),
            let savedReminders = try? JSONDecoder().decode([Reminder].self, from: data)
        else { return }
        
        self.reminders = savedReminders
    }
    
    func deleteReminder(indexSet: IndexSet) {
        reminders.remove(atOffsets: indexSet)
    }
    
    func addReminder(dateAndTime: Date) {
        let newReminder = Reminder(dateAndTime: dateAndTime)
        reminders.append(newReminder)
    }
    
    func saveReminders() {
        if let encodedData = try? JSONEncoder().encode(reminders) {
            UDHelper.sharedUD.createUD(key: UDKey.reminders.rawValue, value: encodedData)
        }
    }
}
