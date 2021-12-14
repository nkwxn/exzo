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
    
    var journalItem: NewJournal? {
        didSet {
            guard let journalItem = journalItem else {
                return
            }
            self.rednessPart = journalItem.rednessPart as! [String]
            self.scratchPart = journalItem.scratchPart as! [String]
            self.swellingPart = journalItem.swellingPart as! [String]
            self.rednessValue = journalItem.rednessScore
            self.scratchValue = journalItem.scratchScore
            self.swellingValue = journalItem.swellingScore
            
            self.stressLevel = journalItem.stressLevel
            self.chosenFoodIntakes = journalItem.foodIntakes?.ieaDatas ?? [IEAData]()
            self.chosenExposure = journalItem.exposures?.ieaDatas ?? [IEAData]()
            self.chosenProducts = journalItem.productIDs?.prods ?? [ListProduct]()
        }
    }
    
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
    @Published var stressLevel = 0.0
    var chosenFoodIntakes = [IEAData]()
    var chosenExposure = [IEAData]()
    var chosenProducts = [ListProduct]()
    
    @Published var chosenTriggerCategory = UDHelper.sharedUD.getTriggers()
    
    // For onboarding only, push navigation to timer
    @Published var pushToTimer = false
    
    init(_ cat: ProfileCategory, mode: JournalMode) {
        self.category = cat
        self.journalMode = mode
        self.journalItem = nil
    }
    
    init(_ cat: ProfileCategory, item: NewJournal) {
        self.category = cat
        self.journalMode = .update
        self.journalItem = item
    }
    
    func pushNavToTimer() {
        if journalMode == .onboarding {
            self.pushToTimer.toggle()
        }
    }
    
    func finishInput(completion: @escaping () -> Void) {
        switch journalMode {
        case .onboarding, .create:
            saveJournal(completion: completion)
        case .update:
            updateJournal(completion: completion)
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
    
    func updateJournal(completion: @escaping () -> Void) {
        guard let safeID = journalItem?.id else { return }
        CDStorage.shared.updateNewJournal(
            id: safeID,
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
