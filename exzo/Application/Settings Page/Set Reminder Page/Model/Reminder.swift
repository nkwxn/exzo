//
//  Reminder.swift
//  exzo
//
//  Created by Deven Nathanael on 23/11/21.
//

import Foundation
import SwiftUI

class Reminder: ObservableObject, Identifiable, Codable {
    var id: UUID
    let dateAndTime: Date
    var isOn: Bool
    var notificationID: String
    
    init(id: UUID = UUID(), dateAndTime: Date, isOn: Bool = true, notificationID: String) {
        self.id = id
        self.dateAndTime = dateAndTime
        self.isOn = isOn
        self.notificationID = notificationID
    }
}
