//
//  JournalInputViewModel.swift
//  exzo
//
//  Created by Nicholas on 24/11/21.
//

import UIKit

class JournalInputViewModel: ObservableObject {
    var category: ProfileCategory
    var journalMode: JournalMode
    
    // For journal input (Skin Condition)
    // Redness
    @Published var rednessPart = [String]()
    @Published var rednessValue = 2.0
    
    // Swelling
    @Published var swellingPart = [String]()
    @Published var swellingValue = 2.0
    
    // Scratch Mark
    @Published var scratchPart = [String]()
    @Published var scratchValue = 2.0
    
    // Percentage done
    @Published var percentageDone: CGFloat = 0.2
    
    // Food Intake, exposure, stress, product
    @Published var stressLevel = 2.0
    var chosenFoodIntakes = [IEAData]()
    var chosenExposure = [IEAData]()
    var chosenProducts = [ListProduct]()
    
    @Published var chosenTriggerCategory = UDHelper.sharedUD.getTriggers()
    
    // For onboarding only, push navigation to timer
    @Published var pushToTimer = false
    
    init(_ cat: ProfileCategory, mode: JournalMode) {
        self.category = cat
        self.journalMode = mode
    }
    
    func pushNavToTimer() {
        if journalMode == .onboarding {
            self.pushToTimer.toggle()
        }
    }
    
    func saveJournal(completion: @escaping () -> Void) {
        CDStorage.shared.createNewJournal(
            rednessPart: self.rednessPart,
            rednessScore: Int(self.rednessValue),
            swellingPart: self.swellingPart,
            swellingScore: Int(self.swellingValue),
            scratchPart: self.scratchPart,
            scratchScore: Int(self.scratchValue),
            foodIntakes: self.chosenFoodIntakes,
            exposure: self.chosenExposure,
            products: self.chosenProducts,
            stressLevel: Int(self.stressLevel),
            completion: completion
        )
    }
}
