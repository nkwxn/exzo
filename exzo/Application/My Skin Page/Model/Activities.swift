//
//  Activities.swift
//  exzo
//
//  Created by Daniella Stefani on 04/11/21.
//

import Foundation
import SwiftUI

struct Activities {
    var id = UUID()
    var activityName: String
    var activityThumb: Image
    var isFavorite: Bool
    
    static var activities: [Activities] {
        [
            Activities(activityName: "Exercise", activityThumb: Image(systemName: "e.circle"), isFavorite: false),
            Activities(activityName: "Work", activityThumb: Image(systemName: "w.circle"), isFavorite: false),
            Activities(activityName: "Jogging", activityThumb: Image(systemName: "j.circle"), isFavorite: false),
            Activities(activityName: "Running", activityThumb: Image(systemName: "r.circle"), isFavorite: false),
            Activities(activityName: "Washing Dishes", activityThumb: Image(systemName: "a.circle"), isFavorite: false),
            Activities(activityName: "Yoga", activityThumb: Image(systemName: "y.circle"), isFavorite: false),
            Activities(activityName: "Cooking", activityThumb: Image(systemName: "c.circle"), isFavorite: false)
        ]
    }
}
