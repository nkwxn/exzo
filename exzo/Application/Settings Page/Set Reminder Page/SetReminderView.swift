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
        
        List {
            ForEach(setReminderViewModel.reminders, id: \.self) { reminder in
                ReminderRowView(reminder: reminder)
//                        UDHelper.sharedUD.saveReminders(reminders: setReminderViewModel.reminders)
//                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            setReminderViewModel.deleteReminder(id: reminder.id)
                        } label: {
                            Image(systemName: "trash")
                        }
                        
                    }
                    .listRowSeparator(.hidden)
            }
            Button(action: {
                setReminderViewModel.isAddReminder.toggle()
            }, label: {
                Text("+ Tambah Pengingat")
            })
                .buttonStyle(ExzoButtonStyle(type: .secondary))
                .padding(20)
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .navigationTitle("Pengingat")
        .navigationBarTitleDisplayMode(.inline)
        
        .sheet(isPresented: $setReminderViewModel.isAddReminder) {
            AddReminderPage(setReminderViewModel: setReminderViewModel)
        }
    }
}

struct SetReminderView_Previews: PreviewProvider {
    static var previews: some View {
        SetReminderView()
    }
}
