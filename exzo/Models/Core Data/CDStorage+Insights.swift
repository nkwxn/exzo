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
        ) { (value, object) -> ([NewJournal], [NewJournal], [NewJournal], [NewJournal]) in
            var value = value
            if let dateAndTime = object.dateAndTime {
                if dateAndTime > Date(timeIntervalSinceNow: 604800) {
                    value.3.append(object)
                } else if dateAndTime > Date(timeIntervalSinceNow: 1209600) {
                    value.2.append(object)
                } else if dateAndTime > Date(timeIntervalSinceNow: 1814400) {
                    value.1.append(object)
                } else if dateAndTime > Date(timeIntervalSinceNow: 2419200) {
                    value.0.append(object)
                }
            }
            return value
        }
    }
    
    // Skin Condition untuk Insight -> [Minggu: Keparahan] Nilai keparahan dari jumlah seluruh dr slider
    func getWeeklyAverageSkinCondition() -> [Int: Double] {
        let splitFiltered = getJournalsForInsight().reduce(
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
        var weeklyAvg = [
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
//    func getInsightItem(for param: IEP) -> [String: [Int: Int]] {}
    
    func getInsightItem(for param: IEP) -> [Dictionary<String, Int>.Element] {
        let filteredJournals = getJournalsForInsight()
        var counts = [String: Int]()
        switch param {
        case .intake, .exposure:
            var items = [IEAData]()
            for filteredJournal in filteredJournals {
                switch param {
                case .exposure:
                    if let exposures = filteredJournal.foodIntakes?.ieaDatas {
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
