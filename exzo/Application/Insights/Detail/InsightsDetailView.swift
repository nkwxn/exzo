//
//  InsightsDetailView.swift
//  exzo
//
//  Created by Nicholas on 18/11/21.
//

import SwiftUI
import Charts

struct InsightsDetailView: View {
    var detail: InsightDetails
//    @ObservedObject var viewModel: InsightsViewModel
    @State var selection = ""
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            // TODO: Query all journal data and show it here!!!
            switch detail {
            case .foodIntake, .exposure, .product:
                VStack {
                    RoundedSquareContainer(autoPadding: true) {
                        Picker("Type", selection: $selection) {
                            Text("Dairy")
                            Text("Noodle")
                            Text("Poultry")
                        }
                        .frame(width: 200)
                        .pickerStyle(DefaultPickerStyle())
                    }
                    RoundedSquareContainer(autoPadding: false) {
                        InsightLineGraph(lineGraphData: .constant(StaticRaw.lineGraphView))
                            .frame(width: nil, height: 400)
                            .padding(.vertical)
                    }
                    RoundedSquareContainer(autoPadding: true) {
                        VStack(alignment: .leading, spacing: 14) {
                            Text("Potential to cause your skin to be more severe this month:")
                            HStack {
                                Spacer()
                                Text("HIGH")
                                    .foregroundColor(.red)
                                Spacer()
                            }
                            Text("There's positive correlation between dairy and the severity of your child's skin condition.")
                        }
                    }
                }
            case .stress:
                VStack {
                    Text("Stress")
                }
            case .skinCon:
                VStack {
                    Text("Skin Condition")
                }
            }
        }
        .navigationTitle(detail.rawValue)
    }
}

// TODO: DELETE THIS AFTER INTEGRATION WITH CORE DATA QUERY
struct StaticRaw {
    static var lineGraphView = [
        ChartDataEntry(x: 1, y: 5),
        ChartDataEntry(x: 2, y: 3),
        ChartDataEntry(x: 3, y: 4),
        ChartDataEntry(x: 4, y: 6),
        ChartDataEntry(x: 5, y: 5)
    ]
}

struct InsightsDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            InsightsDetailView(detail: .stress)
        }
    }
}
