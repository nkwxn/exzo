//
//  NewInsightsViewModel.swift
//  exzo
//
//  Created by Nicholas on 18/01/22.
//

import SwiftUI
import Charts

class NewInsightsViewModel: ObservableObject {
    // Data grafik atas
    @Published var lineChartData = [ChartDataEntry]()
    
    // Data dari Core Data untuk validasi view
    @Published var weeklyJournalData = CDStorage.shared.getSplittedJournalForInsight()
    
    // Slider
    var fokus = ["Asupan Makanan", "Paparan", "Produk", "Stress"]
    let udArr = UDHelper.sharedUD.getConcern()
    @Published var indexFocus = 0
    
    // Selector
    @Published var dropDownList = [String]()
    @Published var value = ""
    
    // Data buat grafik bawah
    var chartData = [String: [String: Int]]() // [Nama: minggu / emoji: Jumlah]
    @Published var barChartData = [BarChartDataEntry]()
    
    // MARK: - Initializer buat dapetin data Insight
    init() {
        self.getWeeklySkinCondition()
        self.getInsightData()
    }
    
    // MARK: - Validate each week's journal input
    public func isWeeklyJournalAvailable() -> Bool {
        let firstWeekNotEmpty = !weeklyJournalData.0.isEmpty
        let secondWeekNotEmpty = !weeklyJournalData.1.isEmpty
        let thirdWeekNotEmpty = !weeklyJournalData.2.isEmpty
        let fourthWeekNotEmpty = !weeklyJournalData.3.isEmpty
        return firstWeekNotEmpty && secondWeekNotEmpty && thirdWeekNotEmpty && fourthWeekNotEmpty
    }
    
    // MARK: - Get line chart for top part
    public func getWeeklySkinCondition() {
        self.lineChartData.removeAll()
        let skinCondition = CDStorage.shared.getWeeklyAverageSkinCondition()
        self.lineChartData = skinCondition
            .sorted { leftVal, rightVal in
                leftVal.key < rightVal.key
            }.map { transforming -> ChartDataEntry in
                ChartDataEntry(x: Double(transforming.key), y: transforming.value)
            }
    }
    
    // MARK: - Get the Insight Data for a particular part
    public func getInsightData() {
        self.dropDownList.removeAll()
        self.chartData.removeAll()
        
        // Insight data depending on index
        let insightData: [Dictionary<String, [Int: Int]>.Element] = {
            switch indexFocus {
            case 0:
                return CDStorage.shared.getWeeklyInsight(for: .intake)
            case 1:
                return CDStorage.shared.getWeeklyInsight(for: .exposure)
            case 2:
                return CDStorage.shared.getWeeklyInsight(for: .product)
            default:
                return [Dictionary<String, [Int: Int]>.Element]()
            }
        }()
        
        var stressLevelData = CDStorage.shared.getMonthlyStressLevelCount()
        
        if indexFocus == 3 {
            dropDownList.append("Tingkat Stres")
            value = dropDownList[0]
            self.chartData[value] = stressLevelData
        } else {
            for datum in insightData {
                dropDownList.append(datum.key)
                self.chartData[datum.key] = datum.value.reduce(into: [String: Int]()) { partialResult, arr1 in
                    partialResult["\(arr1.key)"] = arr1.value
                }
            }
            if !dropDownList.isEmpty {
                value = dropDownList[0]
            }
        }
        
        // Make the data
        showDataOnBarChart()
    }
    
    
    func showDataOnBarChart() {
        self.barChartData.removeAll()
        guard let mappedData = self.chartData[value] else { return }
        self.barChartData = mappedData
            .sorted { leftData, rightData in
                Int(leftData.key) ?? 0 < Int(rightData.key) ?? 0
            }
            .map({ oldValue -> BarChartDataEntry in
                BarChartDataEntry(x: Double(oldValue.key)!, y: Double(oldValue.value))
            })
    }
}
