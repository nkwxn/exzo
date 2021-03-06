//
//  TabContainer.swift
//  Atemis
//
//  Created by Nicholas on 26/10/21.
//

import SwiftUI

struct TabContainer: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        TabView {
            MySkinView()
                .tabItem {
                    Image(systemName: "book.closed")
                    Text("Jurnal")
                }
            NewInsightsView()
                .tabItem {
                    Image(systemName: "chart.pie")
                    Text("Analisis")
                }
            ProductView()
                .tabItem {
                    Image(systemName: "viewfinder.circle")
                    Text("Produk")
                }
        }
        .tabViewStyle(backgroundColor: .white, itemColor: Color.gray, selectedItemColor: Color.accentColor, badgeColor: Color.red)
    }
}

struct TabContainer_Previews: PreviewProvider {
    static var previews: some View {
        ProductView()
    }
}
