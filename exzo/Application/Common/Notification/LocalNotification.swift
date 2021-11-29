////
////  LocalNotification.swift
////  exzo
////
////  Created by Deven Nathanael on 29/11/21.
////
//
//import SwiftUI
//
//class NotificationManager {
//    static let instance = NotificationManager()
//
//    func requestAuthorization() {
//        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
//        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
//            if let error = error {
//                print("ERROR: \(error)")
//            } else {
//                print("SUCCESS")
//            }
//        }
//    }
//
//    func scheduleNotification() {
//        let content  = UNMutableNotificationContent()
//        content.title = "INI NOTIFIKASI BRO"
//        content.subtitle = "Nyeheheheheheheh"
//        content.sound = .default
//        content.badge = 1
//
//        // time
////        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
//        // calendar
//        var dateComponents = DateComponents()
//        dateComponents.hour = 20
//        dateComponents.minute = 26
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//        // location
//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//        UNUserNotificationCenter.current().add(request)
//    }
//}
//struct LocalNotification: View {
//    var body: some View {
//        VStack(spacing: 40) {
//            Button("Request Permission") {
//                NotificationManager.instance.requestAuthorization()
//            }
//            Button("Show Permission") {
//                NotificationManager.instance.scheduleNotification()
//            }
//        }
//    }
//}
//
//struct LocalNotification_Previews: PreviewProvider {
//    static var previews: some View {
//        LocalNotification()
//    }
//}
