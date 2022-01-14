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
    
    // MARK: - Skin Condition untuk Insight -> [Minggu: Keparahan] Nilai keparahan dari jumlah seluruh dr slider
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
    
    // Penghitungan rata2 per minggu dari jurnal (Redness + Swelling + Scratch)
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
    
    // MARK: - Insight mingguan untuk parameter tertentu (asupan makanan, paparan, atau produk) -> [String: [Int: Int]]
    /*
    Cara pemanggilan key: getWeeklyInsight(for: .intake)[i].key
     */
    func getWeeklyInsight(for param: IEP) -> [Dictionary<String, [Int: Int]>.Element] {
        let filteredJournals = getJournalsForInsight()
        let splitFiltered = getSplittedJournalForInsight()
        var itemDictionary = [String: [Int: Int]]()
        
        // Get items from Journal (based on parameter)
        let itemSet: Set<String> = getIEPSet(param, from: filteredJournals)
        
        for item in itemSet {
            let separation = item.components(separatedBy: ": ")
            switch param {
            case .intake, .exposure:
                itemDictionary[separation[1]] = [
                    1: getCount(of: param, from: splitFiltered.0, with: item),
                    2: getCount(of: param, from: splitFiltered.1, with: item),
                    3: getCount(of: param, from: splitFiltered.2, with: item),
                    4: getCount(of: param, from: splitFiltered.3, with: item)
                ]
            case .product:
                itemDictionary[separation[1]] = [
                    1: getCount(of: .product, from: splitFiltered.0, with: item),
                    2: getCount(of: .product, from: splitFiltered.1, with: item),
                    3: getCount(of: .product, from: splitFiltered.2, with: item),
                    4: getCount(of: .product, from: splitFiltered.3, with: item)
                ]
            }
        }
        
        let sorted = itemDictionary.sorted { (leftSet, rightSet) -> Bool in
            let leftValue = leftSet.value
            let rightValue = rightSet.value
            let leftSum = leftValue[1]! + leftValue[2]! + leftValue[3]! + leftValue[4]!
            let rightSum = rightValue[1]! + rightValue[2]! + rightValue[3]! + rightValue[4]!
            return leftSum > rightSum
        }
        return sorted
    }
    
    func getIEPSet(_ param: IEP, from journals: [NewJournal]) -> Set<String> {
        var set = Set<String>()
        for journal in journals {
            switch param {
            case .intake:
                if let intakes = journal.foodIntakes?.ieaDatas {
                    for intake in intakes {
                        set.insert("\(intake.id.uuidString): \(intake.name)")
                    }
                }
            case .exposure:
                if let exposures = journal.exposures?.ieaDatas {
                    for exposure in exposures {
                        set.insert("\(exposure.id.uuidString): \(exposure.name)")
                    }
                }
            case .product:
                if let products = journal.productIDs?.prods {
                    for product in products {
                        if let pType = ProductType(rawValue: product.productCat)?.getLocalizedName() {
                            set.insert("\(product.id.uuidString): \(product.productName) (\(pType))")
                        }
                    }
                }
            }
        }
        return set
    }
    
    func getProductsArr(from journals: [NewJournal]) -> [ListProduct] {
        var arr = [ListProduct]()
        for journal in journals {
            if let products = journal.productIDs?.prods {
                arr.append(contentsOf: products)
            }
        }
        return arr
    }
    
    func getCount(of param: IEP, from journals: [NewJournal], with item: String) -> Int {
        switch param {
        case .intake, .exposure:
            return getIEArr(param, from: journals).filter { ieitem in
                item == "\(ieitem.id.uuidString): \(ieitem.name)"
            }.count
        case .product:
            return getProductsArr(from: journals).filter { prod in
                let pType = ProductType(rawValue: prod.productCat)!.getLocalizedName()
                return item == "\(prod.id.uuidString): \(prod.productName) (\(pType))"
            }.count
        }
    }
    
    func getIEArr(_ param: IEP, from journals: [NewJournal]) -> [IEAData] {
        var arr = [IEAData]()
        for journal in journals {
            switch param {
            case .intake:
                if let intakes = journal.foodIntakes?.ieaDatas {
                    arr.append(contentsOf: intakes)
                }
            case .exposure:
                if let exposures = journal.exposures?.ieaDatas {
                    arr.append(contentsOf: exposures)
                }
            case .product:
                fatalError("Not applicable")
            }
        }
        return arr
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
    
    // MARK: - Rata-rata level stress
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
    
    // MARK: - Kemungkinan besar batal pakai
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
