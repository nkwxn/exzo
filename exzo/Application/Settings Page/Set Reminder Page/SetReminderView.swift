//
//  SetReminderView.swift
//  exzo
//
//  Created by Deven Nathanael on 22/11/21.
//

import SwiftUI

struct SetReminderView: View {
    @ObservedObject var setReminderViewModel = SetReminderViewModel()
    @StateObject private var notificationManager = NotificationManager()
    
    private static var notificationDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()
    
    private func timeDisplayText(from notification: UNNotificationRequest) -> String {
        guard let nextTriggerDate = (notification.trigger as? UNCalendarNotificationTrigger)?.nextTriggerDate() else { return "" }
        return Self.notificationDateFormatter.string(from: nextTriggerDate)
    }
    
    var body: some View {
        List {
            ForEach(setReminderViewModel.reminders) { reminder in
                ReminderRowView(reminder: reminder)
            }
//            ForEach(notificationManager.notifications, id: \.identifier) { notification in
//                HStack {
//                    Text(notification.content.title)
//                    Text(timeDisplayText(from: notification))
//                        .fontWeight(.bold)
//                    Spacer()
//                    
//                }
//            }
            .onDelete(perform: delete)
            Button(action: {
                setReminderViewModel.isAddReminder.toggle()
            }, label: {
                Text("+ Tambah Pengingat")
            })
                .buttonStyle(ExzoButtonStyle(type: .secondary))
                .padding(20)
                .listRowSeparator(.hidden)
        }
        .listStyle(.inset)
        .onAppear(perform: {
            notificationManager.reloadAuthorizationStatus()
        })
        .onChange(of: notificationManager.authorizationStatus) { authorizationStatus in
            switch authorizationStatus {
            case .notDetermined:
                notificationManager.requestAuthorization()
            case .authorized:
                notificationManager.reloadLocalNotifications()
            default:
                break
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            notificationManager.reloadAuthorizationStatus()
        }
        .navigationTitle("Pengingat")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $setReminderViewModel.isAddReminder) {
            AddReminderPage(notificationManager: notificationManager, setReminderViewModel: setReminderViewModel)
        }
    }
}

extension SetReminderView {
    func delete(_ indexSet: IndexSet) {
        notificationManager.deleteLocalNotifications(identifiers: indexSet.map {
            notificationManager.notifications[$0].identifier
        })
        notificationManager.reloadLocalNotifications()
        setReminderViewModel.deleteReminder(at: indexSet)
    }
}

struct SetReminderView_Previews: PreviewProvider {
    static var previews: some View {
        SetReminderView()
    }
}
