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
        dataSet.colors = [UIColor(Color.copper)]
        lineChart.data = LineChartData(dataSet: dataSet)
        lineChart.notifyDataSetChanged()
    }
    
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
