//
//  AddReminderPage.swift
//  exzo
//
//  Created by Deven Nathanael on 26/11/21.
//

import SwiftUI

struct AddReminderPage: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var notificationManager = NotificationManager()
    @ObservedObject var setReminderViewModel: SetReminderViewModel

    @State var selectionDate = Date()
    
    var body: some View {
        NavigationView {
            
            VStack {
                DatePicker("", selection: $selectionDate, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                Spacer()
            }
            .navigationTitle("Tambah Pengingat")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        setReminderViewModel.addReminder(dateAndTime: selectionDate)
                        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: selectionDate)
                        guard let hour = dateComponents.hour, let minute = dateComponents.minute
                        else { return }
                        notificationManager.createLocalNotification(hour: hour, minute: minute, completion: { error in
                            if error == nil {
                                DispatchQueue.main.async {
                                    dismiss.callAsFunction()
                                }
                            }
                        })
                    }, label: {
                        Text("Simpan")
                            .fontWeight(.bold)
                    })
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(role: .cancel, action: {
                        dismiss.callAsFunction()
                    }, label: {
                        Text("Batal")
                    })
                }
            }
            .onDisappear(perform: {
                notificationManager.reloadLocalNotifications()
            })
        }
    }
}
