//
//  NotificationListView.swift
//  exzo
//
//  Created by Deven Nathanael on 29/11/21.
//

import SwiftUI

struct NotificationListView: View {
    @StateObject private var notificationManager = NotificationManager()
    
    var body: some View {
        List(notificationManager.notifications, id: \.identifier) { notification in
            Text(notification.content.title)
                .fontWeight(.semibold)
            
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Notif")
        .onAppear {
            notificationManager.relogAuthorizationStatus()
        }
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
        .navigationBarItems(trailing: Button {
            
        } label: {
            Image(systemName: "plus.circle")
                .imageScale(.large)
        })
    }
}

struct NotificationListView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationListView()
    }
}
