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
    func getJournalsForInsights() -> [NewJournal] {
        // Get data from last 28 days
        let dateRange = DateInterval(start: Date(timeIntervalSinceNow: -2592000), end: Date())
        print(dateRange.start)
        return self.newJournalItems.value.filter { nJournal in
            guard let dateTime =  nJournal.dateAndTime else { return false }
            return dateTime > dateRange.start
        }
    }
    
    // Skin Condition untuk Insight -> [Minggu: Keparahan] Nilai keparahan dari jumlah seluruh dr slider
    func getSkinConditionsForInsight() -> [Int: Int] {
        let filteredJournals = getJournalsForInsights()
        var weeklyAvg = [Int: Int]
        for filteredJournal in filteredJournals {
            
        }
        return [Int: Int]()
    }
    
    // TODO: Mesti di refine lagi agar bisa disesuaikan dengan UI nya
    
    // Insight Item: [Nama Asupan: [Minggu: Jumlah]]
//    func getInsightItem(for param: IEP) -> [String: [Int: Int]] {}
    
    func getInsightItem(for param: IEP) -> [Dictionary<String, Int>.Element] {
        let filteredJournals = getJournalsForInsights()
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
