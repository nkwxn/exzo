//
//  SetReminderView.swift
//  exzo
//
//  Created by Deven Nathanael on 22/11/21.
//

import SwiftUI

struct SetReminderView: View {
    @ObservedObject var setReminderViewModel = SetReminderViewModel()
    
    var body: some View {
        ScrollView {
            ForEach(setReminderViewModel.reminders) { reminder in
                ReminderRowView(reminder: reminder)
                
            }
            Button(action: {
                setReminderViewModel.addReminder(dateAndTime: Date())
            }, label: {
                Text("+ Add Time")
            })
                .buttonStyle(ExzoButtonStyle(type: .secondary))
                .padding(20)
        }
        
        .navigationTitle("Reminder")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SetReminderView_Previews: PreviewProvider {
    static var previews: some View {
        SetReminderView()
    }
}
