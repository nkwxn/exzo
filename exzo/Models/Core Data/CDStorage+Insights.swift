//
//  CDStorage+Insights.swift
//  exzo
//
//  Created by Nicholas on 06/01/22.
//

import CoreData

enum IEP: String {
    case intake
    case exposure
    case product
}

// MARK: - CDStorage Extension for Insights
extension CDStorage {
    func getJournalsForInsight() -> [NewJournal] {
        // Get data from last 28 days
        let dateRange = DateInterval(start: Date(timeIntervalSinceNow: -2592000), end: Date())
        print(dateRange.start)
        return self.newJournalItems.value.filter { nJournal in
            guard let dateTime =  nJournal.dateAndTime else { return false }
            return dateTime > dateRange.start
        }
    }
    
    // swiftlint:disable large_tuple
    func getSplittedJournalForInsight() -> (
        [NewJournal], [NewJournal], [NewJournal], [NewJournal]
    ) {
        getJournalsForInsight().reduce(
            ([NewJournal](), [NewJournal](), [NewJournal](), [NewJournal]())
        ) { (val, object) -> ([NewJournal], [NewJournal], [NewJournal], [NewJournal]) in
            var value = val
            if let dateAndTime = object.dateAndTime {
                if dateAndTime > Date(timeIntervalSinceNow: -604800) {
                    value.3.append(object)
                } else if dateAndTime > Date(timeIntervalSinceNow: -1209600) {
                    value.2.append(object)
                } else if dateAndTime > Date(timeIntervalSinceNow: -1814400) {
                    value.1.append(object)
                } else if dateAndTime > Date(timeIntervalSinceNow: -2419200) {
                    value.0.append(object)
                }
            }
            return value
        }
    }
    
    // Skin Condition untuk Insight -> [Minggu: Keparahan] Nilai keparahan dari jumlah seluruh dr slider
    func getWeeklyAverageSkinCondition() -> [Int: Double] {
        let splitFiltered = getSplittedJournalForInsight()
        let weeklyAvg = [
            1: countSkinAvgFromJournal(from: splitFiltered.0),
            2: countSkinAvgFromJournal(from: splitFiltered.1),
            3: countSkinAvgFromJournal(from: splitFiltered.2),
            4: countSkinAvgFromJournal(from: splitFiltered.3)
        ]
        
        return weeklyAvg
    }
    
    // MARK: - Penghitungan rata2 per minggu dari jurnal (Redness + Swelling + Scratch)
    func countSkinAvgFromJournal(from journals: [NewJournal]) -> Double {
        var average: Double = 0.0
        for journal in journals {
            average += (journal.rednessScore + journal.swellingScore + journal.scratchScore)
        }
        if average != 0 {
            average /= Double(journals.count)
        }
        return average
    }
    
    // TODO: Mesti di refine lagi agar bisa disesuaikan dengan UI nya
    
    // Insight Item: [Nama Asupan: [Minggu: Jumlah]]
    func getWeeklyInsight(for param: IEP) -> [Dictionary<String, [Int: Int]>.Element] {
        let filteredJournals = getJournalsForInsight()
        let splitFiltered = getSplittedJournalForInsight()
        var itemDictionary = [String: [Int: Int]]()
        
        // Set untuk Intake / Exposure dan Product
        var setItem: Set<IEAData> = []
        var setProduct: Set<ListProduct> = []
        
        for filteredJournal in filteredJournals {
            switch param {
            case .intake:
                if let intakes = filteredJournal.foodIntakes?.ieaDatas {
                    for intake in intakes {
                        setItem.insert(intake)
                    }
                }
            case .exposure:
                if let exposures = filteredJournal.exposures?.ieaDatas {
                    for exposure in exposures {
                        setItem.insert(exposure)
                    }
                }
            case .product:
                if let products = filteredJournal.productIDs?.prods {
                    for product in products {
                        setProduct.insert(product)
                    }
                }
            }
        }
        
        // Populate Dictionary Data
        switch param {
        case .intake, .exposure:
            for item in setItem {
                let weeklyCounter = [
                    1: countWeeklyItem(param, for: item, in: splitFiltered.0),
                    2: countWeeklyItem(param, for: item, in: splitFiltered.1),
                    3: countWeeklyItem(param, for: item, in: splitFiltered.2),
                    4: countWeeklyItem(param, for: item, in: splitFiltered.3)
                ]
                
                // Append the weekly data to set
                
                itemDictionary[item.name] = weeklyCounter
            }
        case .product:
            for product in setProduct {
                let weeklyCounter = [
                    1: countWeeklyItem(param, for: product, in: splitFiltered.0),
                    2: countWeeklyItem(param, for: product, in: splitFiltered.1),
                    3: countWeeklyItem(param, for: product, in: splitFiltered.2),
                    4: countWeeklyItem(param, for: product, in: splitFiltered.3)
                ]
                
                itemDictionary[product.productName] = weeklyCounter
            }
        }
        
        // Categorize Item
        return itemDictionary.sorted { leftValue, rightValue in
            let leftSet = leftValue.value
            let rightSet = rightValue.value
            let countLeftSet = (leftSet[1] ?? 0) + (leftSet[2] ?? 0) + (leftSet[3] ?? 0) + (leftSet[4] ?? 0)
            let countRightSet = (rightSet[1] ?? 0) + (rightSet[2] ?? 0) + (rightSet[3] ?? 0) + (rightSet[4] ?? 0)
            return countLeftSet > countRightSet
        }
    }
    
    func countWeeklyItem(_ param: IEP, for item: AnyObject, in journals: [NewJournal]) -> Int {
        var counter = 0
        for journal in journals {
            switch param {
            case .intake:
                if let foodIntakes = journal.foodIntakes?.ieaDatas {
                    for foodIntake in foodIntakes {
                        if foodIntake == (item as? IEAData) { counter += 1 }
                    }
                }
            case .exposure:
                if let exposures = journal.exposures?.ieaDatas {
                    for exposure in exposures {
                        if exposure == (item as? IEAData) { counter += 1 }
                    }
                }
            case .product:
                if let products = journal.productIDs?.prods {
                    for product in products {
                        if product == (item as? ListProduct) { counter += 1 }
                    }
                }
            }
        }
        return counter
    }
    
    // Rata-rata level stress
    func getMonthlyStressLevelCount() -> [String: Int] {
        let filteredJournal = getJournalsForInsight()
        let stressLevelGraphData = [
            "😁": countMonthlyStressLevel(for: filteredJournal, stressLevel: 0), // 0
            "🙂": countMonthlyStressLevel(for: filteredJournal, stressLevel: 1), // 1
            "😐": countMonthlyStressLevel(for: filteredJournal, stressLevel: 2), // 2
            "😢": countMonthlyStressLevel(for: filteredJournal, stressLevel: 3), // 3
            "😭": countMonthlyStressLevel(for: filteredJournal, stressLevel: 4) // 4
        ]
        return stressLevelGraphData
    }
    
    func countMonthlyStressLevel(for journals: [NewJournal], stressLevel: Double) -> Int {
        var counter = 0
        
        // masukkin codingan disini
        for journal in journals {
            if journal.stressLevel == stressLevel {
                counter += 1
            }
        }
        
        return counter
    }
    
    func getCount(for param: IEP) -> [Dictionary<String, Int>.Element] {
        let filteredJournals = getJournalsForInsight()
        var counts = [String: Int]()
        switch param {
        case .intake, .exposure:
            var items = [IEAData]()
            for filteredJournal in filteredJournals {
                switch param {
                case .exposure:
                    if let exposures = filteredJournal.exposures?.ieaDatas {
                        items.append(contentsOf: exposures)
                    }
                case .intake:
                    if let intakes = filteredJournal.foodIntakes?.ieaDatas {
                        items.append(contentsOf: intakes)
                    }
                default:
                    break;
                }
            }
            for item in items {
                counts[item.name] = (counts[item.name] ?? 0) + 1
            }
        case .product:
            var products = [ListProduct]()
            for filteredJournal in filteredJournals {
                if let journalProds = filteredJournal.productIDs?.prods {
                    products.append(contentsOf: journalProds)
                }
            }
            for product in products {
                counts[product.productName] = (counts[product.productName] ?? 0) + 1
            }
        }
        let sorted = counts.sorted { (first, second) -> Bool in
            return first.value > second.value
        }
        return sorted
    }
}
