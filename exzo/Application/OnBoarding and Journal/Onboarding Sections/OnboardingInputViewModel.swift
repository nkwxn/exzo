//
//  OnboardingInputViewModel.swift
//  exzo
//
//  Created by Nicholas on 24/11/21.
//

import Foundation

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
    
    // Food Intake and Exposure
    
    
    init(_ cat: ProfileCategory, mode: JournalMode) {
        self.category = cat
        self.journalMode = mode
    }
}
