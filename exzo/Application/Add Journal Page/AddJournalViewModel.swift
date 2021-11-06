//
//  AddJournalViewModel.swift
//  exzo
//
//  Created by Nicholas on 04/11/21.
//

import SwiftUI

struct BodyTriggerPart {
    var name: String
    var photo: UIImage?
}

enum JournalPageMode: String {
    case add
    case update
}

class AddJournalViewModel: ObservableObject {
    // Slider values (Stress Level)
    @Published var stressLevelSlider = 6.0
    @Published var sliderRange1 = 0...10.0
    @Published var sliderRange2 = 0...3.0
    
    // Grid Items (ambil dr core data or savingan dr cloudkit)
    @Published var foodIntake = [CategoryItem(iconName: "Icon004", name: "Gluten", selected: true), CategoryItem(iconName: "Icon001", name: "Dairy", selected: false)]
    @Published var exposure = [CategoryItem(iconName: "Icon004", name: "Gluten", selected: true), CategoryItem(iconName: "Icon001", name: "Dairy", selected: false)]
    @Published var activities = [CategoryItem(iconName: "Icon004", name: "Gluten", selected: true), CategoryItem(iconName: "Icon001", name: "Dairy", selected: false)]
    
    @Published var selectedIntake = Set<UUID>()
    @Published var selectedExposure = Set<UUID>()
    @Published var selectedActivity = Set<UUID>()
    
    // Skin conditions
    @Published var dryness = 2.0
    @Published var redness = 2.0
    @Published var swelling = 2.0
    @Published var crust = 2.0
    @Published var scratchTraces = 2.0
    @Published var thickSkin = 2.0
    
    @Published var itchiness = 6.0
    @Published var sleepLoss = 6.0
    
    // Trigger areas
    var triggerAreas = [BodyTriggerPart]()
    
    // Done button pressed
    func doneBtnPressed() {
        // if user logged in, save to both cloudkit and coredata
        // else just save to core data
    }
}
