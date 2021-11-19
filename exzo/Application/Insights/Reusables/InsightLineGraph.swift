//
//  InsightLineGraph.swift
//  exzo
//
//  Created by Nicholas on 18/11/21.
//

import SwiftUI
import Charts

struct InsightLineGraph: UIViewRepresentable {
    @Binding var lineGraphData: [ChartDataEntry]
    var lineView = LineChartView()
    
    func makeUIView(context: Context) -> LineChartView {
        lineView.delegate = context.coordinator
        return lineView
    }
    
    func updateUIView(_ lineChart: LineChartView, context: Context) {
        let dataSet = LineChartDataSet(entries: lineGraphData)
        formatDataSet(dataSet: dataSet)
        lineChart.data = LineChartData(dataSet: dataSet)
        
        lineChart.legend.enabled = false
        formatXAXis(xAxis: lineChart.xAxis)
        formatLeftAxis(leftAxis: lineChart.leftAxis)
        formatRightAxis(rightAxis: lineChart.rightAxis)
        
        lineChart.notifyDataSetChanged()
    }
    
    // MARK: Format Chart
    func formatDataSet(dataSet: LineChartDataSet) {
        dataSet.colors = [UIColor(.accentColor)]
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        dataSet.valueFormatter = DefaultValueFormatter(formatter: formatter)
        dataSet.circleColors = [UIColor(.accentColor)]
    }
    
    func formatRightAxis(rightAxis: YAxis) {
        rightAxis.enabled = false
    }
    
    func formatLeftAxis(leftAxis: YAxis) {
        leftAxis.enabled = true
        leftAxis.axisMinimum = 0
        leftAxis.labelTextColor = UIColor.label
        leftAxis.gridColor = .secondaryLabel
    }
    
    func formatXAXis(xAxis: XAxis) {
        xAxis.labelPosition = .bottom
        xAxis.labelTextColor = UIColor(.primary)
        xAxis.drawGridLinesEnabled = false
        xAxis.granularity = 1
        if let first = lineGraphData.first {
            xAxis.axisMinimum = first.x - 0.5
        }
        if let last = lineGraphData.last {
            xAxis.axisMaximum = last.x
        }
    }
    
    // MARK: - Line chart Delegate Method
    class Coordinator: NSObject, ChartViewDelegate {
        let parent: InsightLineGraph
        
        init(parent: InsightLineGraph) {
            self.parent = parent
        }
        
        func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
            
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
}

struct InsightLineGraph_Previews: PreviewProvider {
    static var previews: some View {
        InsightLineGraph(lineGraphData: .constant(StaticRaw.lineGraphView))
    }
}
