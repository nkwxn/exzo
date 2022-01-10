//
//  NewInsightsView.swift
//  exzo
//
//  Created by Daniella Stefani on 29/11/21.
//

import SwiftUI
import Charts

struct NewInsightsView: View {
    var fokus = ["Asupan Makanan", "Paparan", "Produk", "Stress"]
    @State var indexFocus = 0
    @State var isSettingPresented = false
    func placeOrder() { }
    func adjustOrder() { }
    func cancelOrder() { }
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                CustomNavBarView(twoColumnsNavBar: false, title: "Insights", subtitle: nil, showButton: .settingsButton) {
                    // Action untuk buka settings
                    self.isSettingPresented.toggle()
                }
                .padding(.top, 50)
                NavigationLink(destination: SettingsView(profileImage: UDHelper.sharedUD.getPFP(), profileName: UDHelper.sharedUD.getName()), isActive: $isSettingPresented) {
                    EmptyView()
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
                            RoundedSquareContainer(autoPadding: true) {
                                VStack{
                                    HStack{
                                        Text("Tingkat\n Keparahan")
                                            .scaledFont(name: "Avenir", size: 11)
                                            .rotationEffect(Angle(degrees: 0))
                                            .frame(width: 8)
                                        InsightLineGraph(lineGraphData: .constant(StaticRawData.lineGraphView))
                                            .frame(width: nil, height: 300)
                                            .padding(.vertical)
                                    }
                                    Text("Mingguan")
                                }
                            }
                        }
                        
                        VStack(spacing: 15) {
                            HStack {
                                Button() {
                                    print("left button pressed")
                                    if indexFocus > 0 {
                                        self.indexFocus -= 1
                                    }
                                } label: {
                                    Image(systemName: "chevron.left")
                                }
                                .disabled(indexFocus == 0 ? true : false)
                                Spacer()
                                if (indexFocus >= 0 && indexFocus < fokus.count) {
                                    Text("\(fokus[indexFocus])")
                                        .font(Avenir(.title3).getFont().bold())
                                }
                                Spacer()
                                Button() {
                                    print("right button pressed")
                                    if indexFocus <= fokus.count {
                                        self.indexFocus += 1
                                    }
                                } label: {
                                    Image(systemName: "chevron.right")
                                }
                                .disabled(indexFocus >= fokus.count ? true : false)
                                
                            }
                            .padding()
                            
                            RoundedSquareContainer(autoPadding: true) {
                                Menu("Options") {
                                    Button("Order Now", action: placeOrder)
                                    Button("Adjust Order", action: adjustOrder)
                                    Button("Cancel", action: cancelOrder)
                                }
                            }
                            .frame(width: 300, height: 20)
                            .padding()
                            
                            RoundedSquareContainer(autoPadding: true) {
                                VStack{
                                    HStack{
                                        Text("Jumlah")
                                            .scaledFont(name: "Avenir", size: 11)
                                            .rotationEffect(Angle(degrees: 0))
                                            .frame(width: 8)
                                        InsightLineGraph(lineGraphData: .constant(StaticRawData.lineGraphView))
                                            .frame(width: nil, height: 300)
                                            .padding(.vertical)
                                    }
                                    HStack{
                                        Circle()
                                            .frame(width: 15, height: 15)
                                        Text("Produk Susu")
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
            
        }
        
        
    }
    
    // TODO: DELETE THIS AFTER INTEGRATION WITH CORE DATA QUERY
    struct StaticRawData {
        static var lineGraphView = [
            ChartDataEntry(x: 1, y: 5),
            ChartDataEntry(x: 2, y: 3),
            ChartDataEntry(x: 3, y: 4),
            ChartDataEntry(x: 4, y: 6),
        ]
    }
}
