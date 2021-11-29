//
//  NewInsightsView.swift
//  exzo
//
//  Created by Daniella Stefani on 29/11/21.
//

import SwiftUI
import Charts

struct NewInsightsView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavBarView(twoColumnsNavBar: false, title: "Insights", subtitle: nil, showButton: .settingsButton) {
                // Action untuk buka settings
            }
        
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    VStack(spacing: 15) {
                        HStack {
                            Text("Kondisi Kulit")
                                .font(Avenir(.title3).getFont().bold())
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.top)
                        RoundedSquareContainer(autoPadding: false) {
                            InsightLineGraph(lineGraphData: .constant(StaticRawData.lineGraphView))
                                .frame(width: nil, height: 300)
                                .padding(.vertical)
                        }
                    }
                    
                    VStack(spacing: 15) {
                        HStack {
                            Button() {
                                print("left button pressed")
                            } label: {
                                Image(systemName: "chevron.left")
                            }
                            Spacer()
                            Text("Food Intake")
                                .font(Avenir(.title3).getFont().bold())
                            Spacer()
                            Button() {
                                print("right button pressed")
                            } label: {
                                Image(systemName: "chevron.right")
                            }
                            
                        }
                        .padding()
                        
                        RoundedSquareContainer(autoPadding: true) {
                            Text("Picker here lah gajelas gabisa")
                        }
                        .frame(width: 300, height: 20)
                        .padding()
                        
                        RoundedSquareContainer(autoPadding: false) {
                            InsightLineGraph(lineGraphData: .constant(StaticRawData.lineGraphView))
                                .frame(width: nil, height: 300)
                                .padding(.vertical)
                        }
                    }
                }
            }
        }
    }
    
    // TODO: DELETE THIS AFTER INTEGRATION WITH CORE DATA QUERY
    struct StaticRawData {
        static var lineGraphView = [
            ChartDataEntry(x: 1, y: 5),
            ChartDataEntry(x: 2, y: 3),
            ChartDataEntry(x: 3, y: 4),
            ChartDataEntry(x: 4, y: 6),
            ChartDataEntry(x: 5, y: 5)
        ]
    }
}
