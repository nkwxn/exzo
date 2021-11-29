//
//  Reminder.swift
//  exzo
//
//  Created by Deven Nathanael on 23/11/21.
//

import Foundation
import SwiftUI

struct Reminder: Identifiable, Codable, Hashable {
    var id: UUID
    let dateAndTime: Date
    var isOn: Bool
    
    init(id: UUID = UUID(), dateAndTime: Date, isOn: Bool = true) {
        self.id = id
        self.dateAndTime = dateAndTime
        self.isOn = isOn
    }
    
    func updateIsOn() -> Reminder {
        return Reminder(id: id, dateAndTime: dateAndTime, isOn: !isOn)
    }
}
