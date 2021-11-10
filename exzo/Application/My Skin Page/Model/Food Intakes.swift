//
//  FoodIntake.swift
//  exzo
//
//  Created by Daniella Stefani on 04/11/21.
//

import Foundation
import SwiftUI

struct FoodIntakes {
    var id = UUID()
    var intakeName: String
    var intakeThumb: Image
    var isFavorite: Bool
    
    static var foodIntakes: [FoodIntakes] {
        [
            FoodIntakes(intakeName: "Gluten", intakeThumb: Image(systemName: "g.circle"), isFavorite: false),
            FoodIntakes(intakeName: "Seafood", intakeThumb: Image(systemName: "f.circle"), isFavorite: false),
            FoodIntakes(intakeName: "Poultry", intakeThumb: Image(systemName: "p.circle"), isFavorite: false),
            FoodIntakes(intakeName: "Egg", intakeThumb: Image(systemName: "e.circle"), isFavorite: false),
            FoodIntakes(intakeName: "Nut", intakeThumb: Image(systemName: "n.circle"), isFavorite: false),
            FoodIntakes(intakeName: "Dairy", intakeThumb: Image(systemName: "d.circle"), isFavorite: false),
            FoodIntakes(intakeName: "Grain", intakeThumb: Image(systemName: "r.circle"), isFavorite: false)
        ]
    }
}
