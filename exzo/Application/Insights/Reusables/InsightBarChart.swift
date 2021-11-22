//
//  InsightBarChart.swift
//  exzo
//
//  Created by Nicholas on 19/11/21.
//

import SwiftUI
import Charts

struct InsightBarChart: UIViewRepresentable {
    var view = BarChartView()
    
    func makeUIView(context: Context) -> BarChartView {
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ barChart: UIViewType, context: Context) {
        
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

struct InsightBarChart_Previews: PreviewProvider {
    static var previews: some View {
        InsightBarChart()
    }
}
