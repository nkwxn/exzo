//
//  Journal.swift
//  exzo
//
//  Created by Daniella Stefani on 04/11/21.
//

import Foundation
import SwiftUI

struct Journals {
    var id = UUID()
    var dateAndTime: Date
    var foodIntake: [FoodIntakes]
    var stressLevel: Int
    var skinExposure: [Exposures]
    var activities: [Activities]
    var skinCondition: SkinConditions
    var triggerAreas: [TriggerArea]
    
    static var journals: Journals {
//        [
            Journals(dateAndTime: Date(), foodIntake: [
                FoodIntakes(intakeName: "Poultry", intakeThumb: Image(systemName: "p.circle"), isFavorite: false),
                FoodIntakes(intakeName: "Egg", intakeThumb: Image(systemName: "e.circle"), isFavorite: false),
                FoodIntakes(intakeName: "Nut", intakeThumb: Image(systemName: "n.circle"), isFavorite: false),
                FoodIntakes(intakeName: "Nut", intakeThumb: Image(systemName: "n.circle"), isFavorite: false),
                FoodIntakes(intakeName: "Nut", intakeThumb: Image(systemName: "n.circle"), isFavorite: false)
            ], stressLevel: 7, skinExposure: [.sun, .dust], activities: [
                Activities(activityName: "Exercise", activityThumb: Image(systemName: "e.circle"), isFavorite: false),
                Activities(activityName: "Work", activityThumb: Image(systemName: "w.circle"), isFavorite: false)
            ], skinCondition: SkinConditions(dryness: 2, redness: 2, swelling: 2, crust: 2, scratch: 2, thicken: 2, itchiness: 2, sleepLoss: 2, poScorad: 20), triggerAreas: [.backHead])
            
//            Journals(dateAndTime: Date(), foodIntake: [
//                FoodIntakes(intakeName: "Poultry", intakeThumb: Image(systemName: "p.circle"), isFavorite: false),
//                FoodIntakes(intakeName: "Egg", intakeThumb: Image(systemName: "e.circle"), isFavorite: false),
//                FoodIntakes(intakeName: "Nut", intakeThumb: Image(systemName: "n.circle"), isFavorite: false)
//            ], stressLevel: 7, skinExposure: [.sun, .dust], activities: [
//                Activities(activityName: "Exercise", activityThumb: Image(systemName: "e.circle"), isFavorite: false),
//                Activities(activityName: "Work", activityThumb: Image(systemName: "w.circle"), isFavorite: false)
//            ], skinCondition: SkinConditions(dryness: 2, redness: 2, swelling: 2, crust: 2, scratch: 2, thicken: 2, itchiness: 2, sleepLoss: 2), triggerAreas: [.face])
//        ]
    }
}
