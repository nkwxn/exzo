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
    @State var value = ""
    var dropDownList = ["Dairy", "Kacang", "Ikan", "Bebek", "Grain", "Gluten", "Kacang Tanah"]
    @State var indexFocus = 0
    @State var isSettingPresented = false
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                CustomNavBarView(twoColumnsNavBar: false, title: "Insights", subtitle: nil, showButton: .settingsButton) {
                    // Action untuk buka settings
                    self.isSettingPresented.toggle()
                }
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
                                .disabled(indexFocus == fokus.count - 1)
                                
                            }
                            .padding()
                            
                            RoundedSquareContainer(autoPadding: true) {
                                Menu {
                                    ForEach(dropDownList, id: \.self){ client in
                                        Button(client) {
                                            self.value = client
                                        }
                                    }
                                } label: {
                                    VStack(spacing: 5){
                                        HStack{
                                            Text(value.isEmpty ? "Faktor" : value)
                                                .foregroundColor(value.isEmpty ? .gray : .black)
                                            Spacer()
                                            Image(systemName: "chevron.down")
                                                .foregroundColor(Color.orange)
                                                .font(Font.system(size: 20, weight: .bold))
                                        }
                                        .padding(.horizontal)
                                        Rectangle()
                                            .fill(Color.orange)
                                            .frame(height: 2)
                                    }
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
            .navigationBarHidden(true)
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
