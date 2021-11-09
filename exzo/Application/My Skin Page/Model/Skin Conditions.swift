//
//  Skin Condition.swift
//  exzo
//
//  Created by Daniella Stefani on 04/11/21.
//

import Foundation

struct SkinConditions {
    var id = UUID()
    var dryness: Int
    var redness: Int
    var swelling: Int
    var crust: Int
    var scratch: Int
    var thicken: Int
    var itchiness: Int
    var sleepLoss: Int
    var poScorad: Int
    
    func getScore() -> Int {
        let intensity = dryness + redness + swelling + crust + scratch + thicken
        let subjective = itchiness + sleepLoss
        return intensity + subjective
    }
}
