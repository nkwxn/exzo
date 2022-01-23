//
//  NewInsightsView.swift
//  exzo
//
//  Created by Daniella Stefani on 29/11/21.
//

import SwiftUI
import Charts

struct NewInsightsView: View {
    @StateObject var viewModel = NewInsightsViewModel()
    
    var body: some View {
        if viewModel.isWeeklyJournalAvailable() {
            NavigationView {
                VStack(spacing: 0) {
                    CustomNavBarView(twoColumnsNavBar: false, title: "Analisis", subtitle: nil, showButton: nil, action: {})
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
                                RoundedSquareContainer(autoPadding: true) {
                                    VStack(spacing: 0) {
                                        HStack {
                                            Rectangle()
                                                .foregroundColor(.clear)
                                                .frame(width: 10)
                                                .overlay(
                                                    Text("Tingkat keparahan")
                                                        .lineLimit(1)
                                                        .rotationEffect(Angle(degrees: 270))
                                                        .frame(width: 300)
                                                        .scaledFont(name: "Avenir", size: 14)
                                                        .foregroundColor(.secondary)
                                                )
                                            InsightLineGraph(lineGraphData: $viewModel.lineChartData)
                                                .frame(width: nil, height: 300)
                                                .padding(.vertical)
                                        }
                                        Text("Minggu")
                                            .scaledFont(name: "Avenir", size: 14)
                                            .foregroundColor(.secondary)
                                            .offset(x: 0, y: -14)
                                    }
                                }
                            }
                            
                            VStack(spacing: 15) {
                                HStack {
                                    Button() {
                                        print("left button pressed")
                                        if viewModel.indexFocus > 0 {
                                            self.viewModel.indexFocus -= 1
                                        }
                                        viewModel.getInsightData()
                                    } label: {
                                        Image(systemName: "chevron.left")
                                    }
                                    .disabled(viewModel.indexFocus == 0 ? true : false)
                                    Spacer()
                                    if (viewModel.indexFocus >= 0 && viewModel.indexFocus < viewModel.fokus.count) {
                                        Text("\(viewModel.fokus[viewModel.indexFocus])")
                                            .font(Avenir(.title3).getFont().bold())
                                    }
                                    Spacer()
                                    Button() {
                                        print("right button pressed")
                                        if viewModel.indexFocus <= viewModel.fokus.count {
                                            self.viewModel.indexFocus += 1
                                        }
                                        viewModel.getInsightData()
                                    } label: {
                                        Image(systemName: "chevron.right")
                                    }
                                    .disabled(viewModel.indexFocus == viewModel.fokus.count - 1)
                                    
                                }
                                .padding()
                                if viewModel.indexFocus != 3 {
                                    RoundedSquareContainer(autoPadding: true) {
                                        Menu {
                                            ForEach(viewModel.dropDownList, id: \.self) { client in
                                                Button(client) {
                                                    self.viewModel.value = client
                                                }
                                            }
                                        } label: {
                                            HStack {
                                                Text(viewModel.value.isEmpty ? "Faktor" : viewModel.value)
                                                    .foregroundColor(viewModel.value.isEmpty ? .gray : .black)
                                                Spacer()
                                                Image(systemName: "chevron.down")
                                                    .foregroundColor(Color.orange)
                                                    .font(Font.system(size: 20, weight: .bold))
                                            }
                                            .padding(.horizontal)
                                        }
                                    }
                                    .frame(width: 300, height: 20)
                                    .padding()
                                    .onChange(of: viewModel.value) { newValue in
                                        print("Should show bar chart for \(newValue)")
                                        viewModel.showDataOnBarChart()
                                    }
                                }
                                
                                RoundedSquareContainer(autoPadding: true) {
                                    VStack(spacing: 0) {
                                        HStack {
                                            Rectangle()
                                                .foregroundColor(.clear)
                                                .frame(width: 10)
                                                .overlay(
                                                    Text("Jumlah")
                                                        .lineLimit(1)
                                                        .rotationEffect(Angle(degrees: 270))
                                                        .frame(width: 300)
                                                        .scaledFont(name: "Avenir", size: 14)
                                                        .foregroundColor(.secondary)
                                                )
                                            InsightBarChart(barChartData: $viewModel.barChartData, xFormat: $viewModel.xAxisValues)
                                                .frame(width: nil, height: 300)
                                                .padding(.vertical)
                                        }
                                        Text("Minggu")
                                            .scaledFont(name: "Avenir", size: 14)
                                            .foregroundColor(.secondary)
                                            .offset(x: 0, y: -14)
                                        HStack {
                                            Circle()
                                                .frame(width: 15, height: 15)
                                                .foregroundColor(.accentColor)
                                            Text(viewModel.value)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .navigationBarHidden(true)
                .onAppear {
                    viewModel.getWeeklySkinCondition()
                    viewModel.showDataOnBarChart()
                }
            }
        } else {
            TempInsightPlaceholder()
                .navigationBarHidden(true)
                .onAppear {
                    viewModel.getWeeklySkinCondition()
                    viewModel.showDataOnBarChart()
                }
        }
    }
    
    // TODO: DELETE THIS AFTER INTEGRATION WITH CORE DATA QUERY
    struct StaticRawData {
        static var lineGraphView = [
            ChartDataEntry(x: 1, y: 5),
            ChartDataEntry(x: 2, y: 3),
            ChartDataEntry(x: 3, y: 4),
            ChartDataEntry(x: 4, y: 6)
        ]
        
        static var barChartView = [
            BarChartDataEntry(x: 1, y: 19),
            BarChartDataEntry(x: 2, y: 26),
            BarChartDataEntry(x: 3, y: 15),
            BarChartDataEntry(x: 4, y: 17)
        ]
    }
}
