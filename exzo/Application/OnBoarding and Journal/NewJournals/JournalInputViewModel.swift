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
    @Published var chosenFoodIntakes = [IEAData]()
    @Published var chosenFoodIntakes = [IEAData]()
    @Published var chosenProducts = [UUID]()
    
    init(_ cat: ProfileCategory, mode: JournalMode) {
        self.category = cat
        self.journalMode = mode
    }
}
