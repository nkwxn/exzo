//
//  OnboardingSetTimerView.swift
//  exzo
//
//  Created by Nicholas on 25/11/21.
//

import SwiftUI

struct OnboardingSetTimerView: View {
    @Environment(\.modalMode) var modalMode
    @ObservedObject var notificationManager = NotificationManager()
    @State var selectedTime = Date().setHour(h: 12)
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text("Atur pengingat")
                .font(Lexend(.title2)
                        .getFont()
                        .bold())
            Text("Kami akan mengingatkan Anda untuk memasukkan jurnal (sekali sehari) pada saat **anak Anda merasa gatal**. Jangan khawatir, Anda dapat mengubahnya kapan saja melalui **Pengaturan.**")
            HStack {
                Spacer()
                DatePicker("Pilih waktu:", selection: $selectedTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(CompactDatePickerStyle())
                Spacer()
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
            }
            .shadow(radius: 2)
            Spacer()
            Button("Atur pengingat") {
                let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: selectedTime)
                guard let hour = dateComponents.hour, let minute = dateComponents.minute
                else { return }
                notificationManager.createLocalNotification(hour: hour, minute: minute, completion: { error in
                    if error == nil {
                        UNUserNotificationCenter.current().getPendingNotificationRequests { notification in
                            UDHelper.sharedUD.saveReminders(reminders: [Reminder(dateAndTime: selectedTime, notificationID: notification.last?.identifier ?? "")])
                        }
                        dismissModal()
                    }
                })
            }
            .buttonStyle(ExzoButtonStyle(type: .primary))
            HStack {
                Spacer()
                Button("Atur nanti") {
                    // just dismiss modal
                    dismissModal()
                }
                Spacer()
            }
        }
        .padding()
        .navigationBarHidden(true)
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
    }
    
    func dismissModal() {
        UDHelper.sharedUD.setNewUser()
        modalMode.wrappedValue.toggle()
    }
}

struct OnboardingSetTimerView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingSetTimerView()
    }
}
