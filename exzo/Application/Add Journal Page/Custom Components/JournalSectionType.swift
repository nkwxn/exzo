//
//  JournalSectionType.swift
//  exzo
//
//  Created by Nicholas on 04/11/21.
//

import Foundation

enum JournalSectionType: String {
    case foodIntake = "Food intake"
    case stressLevel = "Stress level"
    case exposure = "Exposure"
    case activities = "Activities"
    case skinConditions = "Skin conditions"
    case triggerAreas = "Trigger areas"
    
    func getDescriptions() -> String {
        switch self {
        case .foodIntake:
            return """
**Put your food intake today! Maybe here's one of your food that you consume: **
• Grains: Rice, Corn, etc.
• Gluten: Oat, Barley, etc.
• Seafood: Fish, Shrimp, etc.
• Poultry: Chicken, etc.
• Dairy: Milk, Cheese, etc.
"""
        case .stressLevel:
            return """
**Put your stress level now!**
1: No stress at all
10: Extremely stressful
"""
        case .exposure:
            return "**Put some things you've recently exposed to!**"
        case .activities:
            return "**Put your recent activities that you do!**"
        case .skinConditions:
            return """
**Rate dryness, redness, swelling, crust/oozing, scratch traces, and thickened skin:**
1: A bit dry
2: Quite
3: Severely

**Rate your Itchiness:** 
0-1: Not bothered at all, no itchiness felt
2-3: Very mild itching, only slightly itchier than normal
4-5:  Mild itching, didn’t get itch when doing activities
6-7: Moderate itching, itchy periodically through the day, but didn’t get itch when doing activities. Itchiness could happen at night.
7-8: Severe itching, really disturbs my activities and continues throughout the day and night.
9-10: Extreme itching, itchiness could not be stopped regardless of surroundings and needs to be physically restrained from itching

**Rate your Sleep Condition:**
0-1: Not disturbed at all
2-3: Rarely disturbed my sleep
4-5:  Occasionally disturbed my sleep
6-7: Sometimes disturbed my sleep
7-8: Usually disturbed my sleep
9-10: Can’t sleep at all, happened daily

"""
        case .triggerAreas:
            return """
You can *take a photo* of your skin condition, and *update it everyday* so you can track your skin progress
"""
        }
    }
}
