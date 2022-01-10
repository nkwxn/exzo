//
//  AnalisisView.swift
//  exzo
//
//  Created by Difa N Pratama on 10/01/22.
//

import SwiftUI
import Charts
import simd

struct AnalisisView: View {
    var fokus = ["Asupan Makanan", "Paparan", "Produk", "Stress"]
    @State var isPresented = false
    @State var value = ""
    var placeholder = "Select Client"
    var dropDownList = ["PSO", "PFA", "AIR", "HOT"]
    var body: some View {
        VStack(alignment: .leading) {
            CustomNavBarView(twoColumnsNavBar: false, title: "Insights", subtitle: nil, showButton: .addButton) {
                self.isPresented.toggle()
            }
            Text("Kondisi Kulit")
            InsightLineGraph(lineGraphData: .constant(StaticRaw.lineGraphView))
                .frame(width: 350, height: 303)
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    ForEach(fokus, id: \.self) { index in
                        Text("\(index)")
                            .underline()
                        
                    }
                }
            }
            InsightLineGraph(lineGraphData: .constant(StaticRaw.lineGraphView))
                .frame(width: 350, height: 303)
        }
        
        .edgesIgnoringSafeArea(.all)
    }
}

struct AnalisisView_Previews: PreviewProvider {
    static var previews: some View {
        AnalisisView()
    }
}
