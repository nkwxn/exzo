//
//  XAxisBarFormatter.swift
//  exzo
//
//  Created by Nicholas on 20/01/22.
//

import UIKit
import Charts

@objc(XAxisBarChartFormatter)
public class BarChartFormatter: NSObject, IAxisValueFormatter {
    var axisFormat: [String]!
    
    enum AxisMode {
        case number
        case emoji
    }
    
    init(mode: AxisMode) {
        super.init()
        switch mode {
        case .number:
            axisFormat = ["", "1", "2", "3", "4"]
        case .emoji:
            axisFormat = ["😁", "🙂", "😐", "😢", "😭"]
        }
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return axisFormat[Int(value)]
    }
}
