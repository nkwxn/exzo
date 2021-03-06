//
//  ReminderRowView.swift
//  exzo
//
//  Created by Deven Nathanael on 23/11/21.
//

import SwiftUI

struct ReminderRowView: View {
    @StateObject var reminder: Reminder

    var body: some View {
        HStack {
            HStack {
                Toggle(isOn: $reminder.isOn) {
                    Text(reminder.dateAndTime, style: .time)
                        .font(Lexend(.largeTitle).getFont())
                        .fontWeight(.light)
                }
                .toggleStyle(SwitchToggleStyle(tint: .accentColor))
            }
            .padding()
            .padding(.vertical, 15)
            .background(
                Color.white
            )
            .cornerRadius(19)
            
            .clipped()
            .shadow(color: Color(red: 89/255, green: 58/255, blue: 45/255).opacity(0.12), radius: 10, x: 2, y: 5)
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 5)
    }
}
