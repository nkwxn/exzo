//
//  InsightBarChart.swift
//  exzo
//
//  Created by Nicholas on 19/11/21.
//

import SwiftUI
import Charts

struct InsightBarChart: UIViewRepresentable {
    @Binding var barChartData: [BarChartDataEntry]
    @Binding var xFormat: BarChartFormatter
    var barView = BarChartView()
    
    func makeUIView(context: Context) -> BarChartView {
        barView.delegate = context.coordinator
        return barView
    }
    
    func updateUIView(_ barChart: BarChartView, context: Context) {
        let dataSet = BarChartDataSet(entries: barChartData)
        formatDataSet(dataSet: dataSet)
        
        let barChartData = BarChartData(dataSet: dataSet)
        barChartData.barWidth = 0.3
        barChart.data = barChartData
        barChart.legend.enabled = false
        
        // Axis formatting
        formatXAXis(xAxis: barChart.xAxis)
        formatLeftAxis(leftAxis: barChart.leftAxis)
        formatRightAxis(rightAxis: barChart.rightAxis)
        
        // TODO: X Axis label dibuat disini
        // X Axis Labels
        barChart.xAxis.valueFormatter = xFormat
        
        barChart.notifyDataSetChanged()
    }
    
    func formatDataSet(dataSet: BarChartDataSet) {
        dataSet.colors = [UIColor(.accentColor)]
        dataSet.drawValuesEnabled = false
        dataSet.highlightEnabled = false
    }
    
    func formatRightAxis(rightAxis: YAxis) {
        rightAxis.enabled = false
    }
    
    func formatLeftAxis(leftAxis: YAxis) {
        leftAxis.enabled = true
        
        leftAxis.axisMinimum = 0
        leftAxis.granularity = 1
        leftAxis.labelFont = UIFont(name: "Avenir", size: 14)!
        leftAxis.labelTextColor = UIColor.secondaryLabel
        leftAxis.gridColor = .secondaryLabel
    }
    
    func formatXAXis(xAxis: XAxis) {
        xAxis.labelPosition = .bottom
        
        xAxis.labelFont = UIFont(name: "Avenir", size: 14)!
        xAxis.labelTextColor = UIColor.secondaryLabel
        
        xAxis.drawGridLinesEnabled = false
        xAxis.granularity = 1
        if let first = barChartData.first {
            xAxis.axisMinimum = first.x - 0.5
        }
        if let last = barChartData.last {
            xAxis.axisMaximum = last.x + 0.5
        }
    }
    
    
    // MARK: - Bar Chart View Model
    class Coordinator: NSObject, ChartViewDelegate {
        let parent: InsightBarChart
        
        init(parent: InsightBarChart) {
            self.parent = parent
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
}
